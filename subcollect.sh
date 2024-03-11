#!/bin/bash


if ping -c 3 $1 &> /dev/null
then
  printf "Starting subcollect against $1 ..."
else
  printf "Connection to   $1    cannot be established"   
  exit 1
fi

folderName=$1Subcollect

printf "\n\nCreating Project Folder in Current Working Directory:"

echo -n $folderName | sudo tee /opt/subcollect/folderNameTransfer.txt

mkdir -p $folderName
mkdir -p $folderName/outputs


printf "\n\nRunning amass\n\n"

amass enum -d $1 -active -brute recursive >> $folderName/outputs/amassOutputTemp.txt

amassOutput=$(cat $folderName/outputs/amassOutputTemp.txt)

if [ "$amassOutput" == "No assets were discovered" ];then
  printf "amass didn't return any subdomanins! Rerunning... 
  amass enum -d $1 -active -brute recursive >> $folderName/outputs/amassOutputTemp.txt
fi

cp  $folderName/outputs/amassOutputTemp.txt $folderName/outputs/amassOutputTempPREPYTHON.txt

printf "\n\nParsing domains out of $folderName/outputs/amassOutputTemp.txt into $folderName/outputs/amassOutput.txt\n\n"

sudo python3 /opt/subcollect/scripts/amassOutFilterOutSubDomainsOnly.py

printf "\n\nRemoving irrelevant domains from $folderName/outputs/amassOutput.txt\n\n"

sudo python3 /opt/subcollect/scripts/amassOutputFilterIrrelevant.py $(pwd)/$folderName/outputs/amassOutput.txt $1

printf "\n\nRunning puredns\n\n"


#LATER CHANGE TO WORDLIST: /opt/subcollect/allDNSWordlists.txt


puredns bruteforce /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt $1 -l 500 -w $folderName/outputs/purednsOutput.txt

printf "\n\nMerging tool outputs into combined $folderNamen/outputs/domainList.txt\n\n"

cat $folderName/outputs/amassOutput.txt >> $folderName/outputs/domainList.txt
cat $folderName/outputs/purednsOutput.txt >> $folderName/outputs/domainList.txt

dpwg $folderName/outputs/domainList.txt $folderName/outputs/customWordlistFromDPWG.txt

gotator -sub $folderName/outputs/domainList.txt -prefixes -perm $folderName/outputs/customWordlistFromDPWG.txt -md -depth 1 -silent -t 1000 -adv | duplicut -o $folderName/outputs/tempList.txt && puredns resolve $folderName/outputs/tempList.txt -w $folderName/outputs/gotatorResolvedPermutions.txt

cat $folderName/outputs/gotatorResolvedPermutions.txt >> $folderName/outputs/domainList.txt

mkdir $folderName/outputs/finalOutput

duplicut $folderName/outputs/domainList.txt -o $folderName/outputs/finalOutput/domainList.txt
