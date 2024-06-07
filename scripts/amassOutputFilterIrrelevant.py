import sys
import re

inputFile = sys.argv[1]
targetDomain = sys.argv[2]

filteredSubdomainArray = []

targetDomainArray = targetDomain.split(".")

OnlyReleventDomainsRegex = ""

#Dynamic regex builder

for i in range(len(targetDomainArray) - 1):
    OnlyReleventDomainsRegex += targetDomainArray[i] + "\."

    if( i == len(targetDomainArray) - 1):
        OnlyReleventDomainsRegex = OnlyReleventDomainsRegex[:-2]
        OnlyReleventDomainsRegex += "$"

# Write changes

with open(inputFile, "r") as file:
    for line in file:
        filteredDomains = re.findall(OnlyReleventDomainsRegex, line)
        for goodDomain in filteredDomains:
            filteredSubdomainArray.append(goodDomain)


#clear file
with open(inputFile, 'w') as file:
    pass

for filteredSubdomain in filteredSubdomainArray:
    with open(inputFile, "a") as file:
        file.write(filteredSubdomain + "\n")


