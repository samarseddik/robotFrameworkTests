*** Settings ***
Documentation    Test cases for NetworkKeywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/CommonUI.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/NavigationKeywords.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/FormKeywords.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/NetworkKeywords.robot
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup       Run Keywords
...    Browser.Delete All Cookies    AND
...    Navigate To URL    ${URL}

*** Variables ***
${URL}                  https://bms.startnow-fr.com
${BROWSER}              chromium
${HEADLESS}             False
${EMAIL_SELECTOR}       input[type="email"]
${PASSWORD_SELECTOR}    input[type="password"]
${SUBMIT_SELECTOR}      button[type="submit"]
${EMAIL}                superAdmin@start-now.fr
${PASSWORD}             BMSstart10*
${LOGIN_API}            **/backend/api/auth/login

*** Test Cases ***
TC-NET-001 Wait For Request
    [Documentation]    Verifies that the login request is detected when form is submitted.
    [Tags]             network    request
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    ${promise}=    Promise To    Wait For Request    ${LOGIN_API}
    Click    ${SUBMIT_SELECTOR}
    ${request}=    Wait For    ${promise}
    Should Not Be Empty    ${request}

TC-NET-002 Wait For Response
    [Documentation]    Verifies that the login response is received.
    [Tags]             network    response
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Click    ${SUBMIT_SELECTOR}
    ${response}=    Wait For Response    ${LOGIN_API}
    Should Not Be Empty    ${response}

TC-NET-003 Verify Response Status
    [Documentation]    Verifies that the login response has a 200 status.
    [Tags]             network    response
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Click    ${SUBMIT_SELECTOR}
    Verify Response Status    ${LOGIN_API}    200

TC-NET-004 Verify Request Was Made
    [Documentation]    Verifies that the login request was made after submitting the form.
    [Tags]             network    request
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    ${promise}=    Promise To    Wait For Request    ${LOGIN_API}
    Click    ${SUBMIT_SELECTOR}
    Wait For    ${promise}
    
TC-NET-005 Verify Response Contains
    [Documentation]    Verifies that the login response contains a token.
    [Tags]             network    response
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Click    ${SUBMIT_SELECTOR}
    Verify Response Contains    ${LOGIN_API}    accessToken

TC-NET-006 Set Network Offline And Online
    [Documentation]    Verifies that network can be set offline and back online.
    [Tags]             network    conditions
    Set Network Offline
    Set Network Online