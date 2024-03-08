folderName=$1Subcollect

echo $folderName -n | sudo tee /opt/subcollect/folderNameTransfer.txt

mkdir -p $folderName

amass enum -d $1 -active -brute recursive -ip -src -o $folderName/outputs/amassOutputTemp.txt -v

sudo python3 /opt/subcollect/scripts/amassOutFilterOutSubDomainsOnly.py

puredns bruteforce /usr/share/wordlists/seclists/Discovery/DNS/combined_subdomains.txt $1 -l 500 -w $folderName/outputs/purednsOutput.txt

cat $folderName/outputs/amassOutput.txt >> $folderName/outputs/domainList.txt
cat $folderName/outputs/purednsOutput.txt >> $folderName/outputs/domainList.txt

#use dpwg to create wordlist from domainList

#gotator -sub subdomains.txt -prefixes -perm customWordlistFromDPWG -md -depth 1 -silent -t 1000 -adv | duplicut -o tempList.txt && puredns resolve tempList.txt -w gotatorOutput.txt
