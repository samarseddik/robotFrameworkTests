*** Settings ***
Documentation    Test cases for ApiValidation keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/api/ApiClient.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/api/ApiAuth.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/api/ApiValidation.robot
Suite Setup      Run Keywords
...    Create API Session    ${BASE_URL}    AND
...    Login And Set Token
Suite Teardown   Delete API Session

*** Variables ***
${BASE_URL}             https://bms.startnow-fr.com/backend/api
${LOGIN_ENDPOINT}       /auth/login
${DASHBOARD_ENDPOINT}   /dashboard/charts
${EMAIL}                superAdmin@start-now.fr
${PASSWORD}             BMSstart10*

*** Keywords ***
Login And Set Token
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    Set Bearer Token    ${token}

*** Test Cases ***
TC-VAL-API-001 Validate Status Code 200
    [Documentation]    Verifies that login returns status 200.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${result}=    Validate Status Code    200
    Should Be True    ${result}

TC-VAL-API-002 Validate Status Code In List
    [Documentation]    Verifies that status code is in expected list.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${expected}=    Create List    ${200}    ${201}    ${204}
    ${result}=    Validate Status Code In List    ${expected}
    Should Be True    ${result}

TC-VAL-API-003 Validate Response Body Is Not Empty
    [Documentation]    Verifies that response body is not empty.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${result}=    Validate Response Body Is Not Empty
    Should Be True    ${result}

TC-VAL-API-004 Validate Response Is JSON
    [Documentation]    Verifies that response body is valid JSON.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${result}=    Validate Response Is JSON
    Should Be True    ${result}

TC-VAL-API-005 Validate Response Body Contains Key
    [Documentation]    Verifies that response body contains accessToken key.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${result}=    Validate Response Body Contains Key    accessToken
    Should Be True    ${result}

TC-VAL-API-006 Validate Response Body Field Value
    [Documentation]    Verifies that response body field has expected value.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${body_json}=    Get Response Body    ${response}
    Log    Response keys: ${body_json}
    ${result}=    Validate Response Body Contains Key    accessToken
    Should Be True    ${result}

TC-VAL-API-007 Validate Response Header Contains
    [Documentation]    Verifies that response contains Content-Type header.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${result}=    Validate Response Header Contains    Content-Type
    Should Be True    ${result}

TC-VAL-API-008 Validate Response Time
    [Documentation]    Verifies that response time is within 5 seconds.
    [Tags]             api    validation
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${elapsed}=    Validate Response Time    5
    Should Be True    ${elapsed} > 0

TC-VAL-API-009 Validate Dashboard Response
    [Documentation]    Verifies dashboard endpoint returns valid response.
    [Tags]             api    validation
    ${headers}=    Get Auth Headers
    ${params}=    Create Dictionary    building_id=1
    GET Request    ${DASHBOARD_ENDPOINT}    headers=${headers}    params=${params}
    Validate Status Code    200
    Validate Response Is JSON
    Validate Response Body Is Not Empty