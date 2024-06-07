import sys
import re

inputFile = sys.argv[1]
targetDomain = sys.argv[2]

filteredSubdomainArray = []

targetDomainArray = targetDomain.split(".")

# If match get the entire subdomain(whole line)

OnlyReleventDomainsRegex = ".*\."

#Dynamic regex builder

for i in range(len(targetDomainArray)):
    OnlyReleventDomainsRegex += targetDomainArray[i] + "\."

    if( i == len(targetDomainArray) - 1):
        OnlyReleventDomainsRegex = OnlyReleventDomainsRegex[:-2]
        OnlyReleventDomainsRegex += "$"

#Result of the above will be a regex like:     .*\.example\.com$    Which matches any subdomain that that has the targetDomain in it and at the end (prevent example.com.cloudflare.com and similar)

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


