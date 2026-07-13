*** Settings ***
Documentation    Test cases for ApiClient keywords.
Resource    ${KEYWORDS_PATH}/api/ApiClient.robot
Resource    ${KEYWORDS_PATH}/api/ApiConfig.robot
Suite Setup      Create API Session    ${BASE_URL}
Suite Teardown   Delete API Session

*** Variables ***
${BASE_URL}         https://bms.startnow-fr.com/backend/api
${LOGIN_ENDPOINT}   /auth/login
${EMAIL}            superAdmin@start-now.fr
${PASSWORD}         BMSstart10*
${DASHBOARD_ENDPOINT}    /dashboard/charts

*** Test Cases ***
TC-CLI-001 Create API Session
    [Documentation]    Verifies that an API session can be created.
    [Tags]             api    client
    ${result}=    Verify API Session Is Active
    Should Be True    ${result}

TC-CLI-002 POST Request Login
    [Documentation]    Verifies that a POST request to login endpoint works.
    [Tags]             api    client
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    Should Not Be Equal    ${response}    ${None}

TC-CLI-003 Get Response Status Code
    [Documentation]    Verifies that response status code is returned correctly.
    [Tags]             api    client
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${status}=    Get Response Status Code
    Should Be Equal As Integers    ${status}    200

TC-CLI-004 Get Response Body
    [Documentation]    Verifies that response body is returned correctly.
    [Tags]             api    client
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${response_body}=    Get Response Body
    Should Not Be Empty    ${response_body}


TC-CLI-005 Get Last Response
    [Documentation]    Verifies that last response is stored and returned.
    [Tags]             api    client
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${last}=    Get Last Response
    Should Not Be Equal    ${last}    ${None}

TC-CLI-006 GET Request
    [Documentation]    Verifies that a GET request works correctly.
    [Tags]             api    client
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${login}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${login.json()}[accessToken]
    ${headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${params}=    Create Dictionary    building_id=1
    ${response}=    GET Request    /dashboard/charts    headers=${headers}    params=${params}
    Should Not Be Equal    ${response}    ${None}
    ${status}=    Get Response Status Code    ${response}
    Should Be Equal As Integers    ${status}    200

TC-CLI-007 Delete API Session
    [Documentation]    Verifies that API session can be deleted.
    [Tags]             api    client
    ${result}=    Delete API Session
    Should Be True    ${result}