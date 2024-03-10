import sys

inputFile = sys.argv[1]
targetDomain = sys.argv[2]

filteredSubdomainArray = []

with open(inputFile, "r") as file:
    for line in file:
        if targetDomain in line:
            filteredSubdomainArray.append(line)


#clear file
with open(inputFile, 'w') as file:
    pass

for filteredSubdomain in filteredSubdomainArray:
    with open(inputfile, "a") as file:
        file.write(filteredSubdomain + "\n")


