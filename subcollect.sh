folderName=$1Subcollect


echo "\n\nCreating Project Folder in Current Working Directory:"

echo -n $folderName | sudo tee /opt/subcollect/folderNameTransfer.txt

mkdir -p $folderName
mkdir -p $folderName/outputs


echo "\n\nRunning amass\n\n"

amass enum -d $1 -active -brute recursive

cp ~/.config/amass/amass.txt $folderName/outputs/amassOutputTemp.txt

echo "\n\nParsing domains out of $folderName/outputs/amassOutputTemp.txt into $folderName/outputs/amassOutput.txt\n\n"

sudo python3 /opt/subcollect/scripts/amassOutFilterOutSubDomainsOnly.py

echo "\n\nRunning puredns\n\n"

puredns bruteforce /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt $1 -l 500 -w $folderName/outputs/purednsOutput.txt

echo "\n\nMerging tool outputs into combined $folderNamen/outputs/domainList.txt\n\n"

cat $folderName/outputs/amassOutput.txt >> $folderName/outputs/domainList.txt
cat $folderName/outputs/purednsOutput.txt >> $folderName/outputs/domainList.txt

python3 dpwg.py $folderName/outputs/domainList.txt

#gotator -sub subdomains.txt -prefixes -perm customWordlistFromDPWG -md -depth 1 -silent -t 1000 -adv | duplicut -o tempList.txt && puredns resolve tempList.txt -w gotatorOutput.txt
