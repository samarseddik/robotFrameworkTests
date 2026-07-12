*** Settings ***
Documentation    Test cases for ApiAuth keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/api/ApiClient.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/api/ApiAuth.robot
Suite Setup      Create API Session    ${BASE_URL}
Suite Teardown   Delete API Session

*** Variables ***
${BASE_URL}         https://bms.startnow-fr.com/backend/api
${LOGIN_ENDPOINT}   /auth/login
${EMAIL}            superAdmin@start-now.fr
${PASSWORD}         BMSstart10*

*** Test Cases ***
TC-AUTH-001 Set Bearer Token
    [Documentation]    Verifies that bearer token authentication can be configured.
    [Tags]             api    auth
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    ${headers}=    Set Bearer Token    ${token}
    Dictionary Should Contain Key    ${headers}    Authorization

TC-AUTH-002 Get Auth Headers
    [Documentation]    Verifies that auth headers are returned after configuration.
    [Tags]             api    auth
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    Set Bearer Token    ${token}
    ${headers}=    Get Auth Headers
    Should Not Be Empty    ${headers}
    Dictionary Should Contain Key    ${headers}    Authorization

TC-AUTH-003 Get Auth Type Bearer
    [Documentation]    Verifies that auth type is Bearer after configuration.
    [Tags]             api    auth
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    Set Bearer Token    ${token}
    ${auth_type}=    Get Auth Type
    Should Be Equal    ${auth_type}    Bearer

TC-AUTH-004 Set Basic Auth
    [Documentation]    Verifies that Basic authentication can be configured.
    [Tags]             api    auth
    ${headers}=    Set Basic Auth    ${EMAIL}    ${PASSWORD}
    Dictionary Should Contain Key    ${headers}    Authorization
    Should Contain    ${headers}[Authorization]    Basic

TC-AUTH-005 Get Auth Type Basic
    [Documentation]    Verifies that auth type is Basic after configuration.
    [Tags]             api    auth
    Set Basic Auth    ${EMAIL}    ${PASSWORD}
    ${auth_type}=    Get Auth Type
    Should Be Equal    ${auth_type}    Basic

TC-AUTH-006 Set API Key Auth
    [Documentation]    Verifies that API key authentication can be configured.
    [Tags]             api    auth
    ${headers}=    Set API Key Auth    my-api-key-123
    Dictionary Should Contain Key    ${headers}    X-API-Key

TC-AUTH-007 Get Auth Type API Key
    [Documentation]    Verifies that auth type is API_KEY after configuration.
    [Tags]             api    auth
    Set API Key Auth    my-api-key-123
    ${auth_type}=    Get Auth Type
    Should Be Equal    ${auth_type}    API_KEY

TC-AUTH-008 Merge Auth With Headers
    [Documentation]    Verifies that auth headers can be merged with extra headers.
    [Tags]             api    auth
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    Set Bearer Token    ${token}
    ${extra}=    Create Dictionary    X-Custom-Header=custom-value
    ${merged}=    Merge Auth With Headers    ${extra}
    Dictionary Should Contain Key    ${merged}    Authorization
    Dictionary Should Contain Key    ${merged}    X-Custom-Header

TC-AUTH-009 Clear Auth
    [Documentation]    Verifies that authentication configuration can be cleared.
    [Tags]             api    auth
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${response}=    POST Request    ${LOGIN_ENDPOINT}    body=${body}
    ${token}=    Set Variable    ${response.json()}[accessToken]
    Set Bearer Token    ${token}
    ${result}=    Clear Auth
    Should Be True    ${result}
    ${auth_type}=    Get Auth Type
    Should Be Equal    ${auth_type}    ${None}