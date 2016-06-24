#!/usr/bin/env python
import xml.etree.ElementTree as ET
import pprint
import sys
from testrail import *
import re
testRailURL='https://chegg.testrail.com/'
userName='corexeng@chegg.com'
password='testing'
projectId='24'  # For core project



def updateResults(fileName):
    tree = ET.parse(fileName)
    root = tree.findall("testcase")
    resultset=[]
    client = APIClient(testRailURL)
    client.user = userName
    client.password = password
    # Get Run ID
    runs = client.send_get('get_runs/' + projectId)
    lastRun = runs[-1]
    testRunID = str(lastRun["id"])
    testInRun = client.send_get('get_tests/' + testRunID)


    updatedId=[]
    for testcase in root:
        testcaseID=str(testcase.get('name').split()[0])
        error=testcase.findall("error[@type]")
        if len(error) is 0:
            resultStatus="1"     # PASS
            resultComment="Test passes in automated run"
        else:
            resultStatus="5"     # Failed
            automationErrorMsg=testcase.find("error").text.split("\n")
            for i in automationErrorMsg:
                if "ERROR" in i:
                    ErrorMsg=i
            resultComment="Test failed in automated run, error message : \n" + ErrorMsg
        #print ("verifying test : ",testcaseID)
        for tcId in testInRun:
            if str(testcaseID) == str(tcId["case_id"]):
                #print ("test found in run : ",testcaseID)
                resultNode={"case_id" : testcaseID , "status_id" : resultStatus, "comment": resultComment}
                updatedId.append(testcaseID)
                resultset.append(resultNode)
    #print(resultset)


    #testRunID="126"
    #print("add_results_for_cases/" + testRunID, {"results " : resultset})
    client.send_post("add_results_for_cases/" + testRunID, {"results" : resultset})
    print("Updated results for : " + str(updatedId))



def getArgs():
    fileName=sys.argv[1];
    return fileName


fileName=getArgs()
updateResults(fileName)