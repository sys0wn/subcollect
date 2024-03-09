import re
import os

currentWorkDir = os.getcwd()

with open("/opt/subcollect/folderNameTransfer.txt", "r") as file:
    projectFolderPath = currentWorkDir + "/" + file.read()


regex = r'^(?!-)(?![\d.]+)((?:\w+\.)+\w+)'

with open(projectFolderPath + "/outputs/amassOutputTemp.txt","r") as file:
    fileContentAmassOutput = file.read()


filteredDomains = re.findall(regex, fileContentAmassOutput)


with open(projectFolderPath + "/outputs/amassOutput.txt", "a") as file:
    for filteredDomain in filteredDomains:
        file.write(filteredDomain)
