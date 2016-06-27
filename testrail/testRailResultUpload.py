#!/usr/bin/env python
import xml.etree.ElementTree as ET
import sys
from testrail import *
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
    lastRun = runs[0]
    testRunID = str(lastRun["id"])
    testInRun = client.send_get('get_tests/' + testRunID)
    ErrorMsg="";
    ErrorMsgLast=""
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
                if "Message" in i or "ERROR" in i or "error" in i:
                    ErrorMsg=i + ErrorMsgLast
                    ErrorMsgLast=i;
            resultComment="Test failed in automated run, error message : \n" + ErrorMsg
        for tcId in testInRun:
            if str(testcaseID) == str(tcId["case_id"]):
                resultNode={"case_id" : testcaseID , "status_id" : resultStatus, "comment": resultComment}
                updatedId.append(testcaseID)
                resultset.append(resultNode)
    client.send_post("add_results_for_cases/" + testRunID, {"results" : resultset})
    print("Updated results for : " + str(updatedId))


def get_args():
    fileName=sys.argv[1];
    return fileName


fileName = get_args()
updateResults(fileName)
