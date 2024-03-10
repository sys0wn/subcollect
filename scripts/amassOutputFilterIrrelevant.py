import sys

inputFile = sys.argv[1]

filteredSubdomainArray = []

with open(inputFile, "r") as file:
    for line in file:
        if "minh.monster" in line:
            filteredSubdomainArray.append(line)


for filteredSubdomain in filteredSubdomainArray:
    print(filteredSubdomain)

#with open(inputfile, "w") as file:
#    file.write()
