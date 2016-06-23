#!/usr/bin/env python
import xml.etree.ElementTree as ET
import pprint
import sys
from testrail import *

testRailURL='https://chegg.testrail.com/'
userName='corexeng@chegg.com'
password='testing'
projectId='24'  # For core project



def updateResults(filename):
    tree = ET.parse(fileName)
    root = tree.findall("testcase")
    resultset=[]
    for testcase in root:
        testcaseID=testcase.get('name').split()[0]
        error=testcase.findall("error[@type]")
        if len(error) is 0:
            result="PASS"
        else:
            result="Failed"
        #print (testcaseID + " : " + result);
        result={"case_id" : testcaseID , "status_id" : 5 , "comment" : "test failed"}
        resultset.append(result)
    client = APIClient(testRailURL)
    client.user = userName
    client.password = password
    # Get Run ID
    #case = client.send_get('get_case/5714')
    #runs = client.send_get('get_runs/' + projectId)
    #lastRun=runs[-1]
    #testRunID=str(lastRun["id"])
    testRunID="126"
    testcaseID="5713"
    print("add_results_for_cases/" + testRunID, {"results " : resultset})
    exit
    client.send_post("add_results_for_cases/" + testRunID, {"results" : resultset})



def getArgs():
    fileName=sys.argv[1];
    return fileName


fileName=getArgs()
updateResults(fileName)