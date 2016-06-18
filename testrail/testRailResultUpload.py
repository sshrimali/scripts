import xml.etree.ElementTree as ET

import sys


def getTestIds(filename):
    tree = ET.parse(fileName)
    root = tree.findall("testcase")
    for testcase in root:
        print testcase.get('name')


def getArgs():
    fileName=sys.argv[1];
    return fileName

def updateResults():
    print ("test");

fileName=getArgs()
getTestIds(fileName)
updateResults()