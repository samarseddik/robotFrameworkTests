*** Settings ***
Documentation    Test cases for ValidationKeywords.
Resource         ${KEYWORDS_PATH}/ui/CommonUI.robot
Resource         ${KEYWORDS_PATH}/ui/NavigationKeywords.robot
Resource         ${KEYWORDS_PATH}/ui/FormKeywords.robot
Resource         ${KEYWORDS_PATH}/ui/ValidationKeywords.robot
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
${HEADING_SELECTOR}     h2
${EMAIL}                superAdmin@start-now.fr
${PASSWORD}             BMSstart10*

*** Test Cases ***
TC-VAL-UI-001 Verify Element Is Visible
    [Documentation]    Verifies that the email field is visible.
    [Tags]             ui-validation    visibility
    Verify Element Is Visible    ${EMAIL_SELECTOR}

TC-VAL-UI-002 Verify Element Exists
    [Documentation]    Verifies that the email field exists in the DOM.
    [Tags]             ui-validation    visibility
    Verify Element Exists    ${EMAIL_SELECTOR}

TC-VAL-UI-003 Verify Element Does Not Exist
    [Documentation]    Verifies that a non-existent element is not in the DOM.
    [Tags]             ui-validation    visibility
    Verify Element Does Not Exist    div.non-existent-element-xyz

TC-VAL-UI-004 Get Element Text
    [Documentation]    Verifies that element text is returned correctly.
    [Tags]             ui-validation    text
    ${text}=    Get Element Text    ${HEADING_SELECTOR}
    Should Not Be Empty    ${text}

TC-VAL-UI-005 Verify Element Text Contains
    [Documentation]    Verifies that heading text contains expected words.
    [Tags]             ui-validation    text
    Verify Element Text Contains    ${HEADING_SELECTOR}    sign-in

TC-VAL-UI-006 Verify Element Text Matches
    [Documentation]    Verifies that heading text matches a pattern.
    [Tags]             ui-validation    text
    Verify Element Text Matches    ${HEADING_SELECTOR}    .*sign-in.*

TC-VAL-UI-007 Get Element Attribute
    [Documentation]    Verifies that element attribute is returned correctly.
    [Tags]             ui-validation    attribute
    ${value}=    Get Element Attribute    ${EMAIL_SELECTOR}    type
    Should Be Equal    ${value}    email

TC-VAL-UI-008 Verify Element Attribute
    [Documentation]    Verifies that email field has type attribute equal to email.
    [Tags]             ui-validation    attribute
    Verify Element Attribute    ${EMAIL_SELECTOR}    type    email

TC-VAL-UI-009 Verify Element Has Class
    [Documentation]    Verifies that email field has chakra-input class.
    [Tags]             ui-validation    attribute
    Verify Element Has Class    ${EMAIL_SELECTOR}    chakra-input

TC-VAL-UI-010 Verify Element Count
    [Documentation]    Verifies that there is exactly one email field on the page.
    [Tags]             ui-validation    attribute
    Verify Element Count    ${EMAIL_SELECTOR}    1

TC-VAL-UI-011 Verify Element Is Enabled
    [Documentation]    Verifies that the submit button is enabled.
    [Tags]             ui-validation    state
    Verify Element Is Enabled    ${SUBMIT_SELECTOR}

TC-VAL-UI-012 Verify Page Title Contains
    [Documentation]    Verifies that the page title contains expected text.
    [Tags]             ui-validation    page
    Verify Page Title Contains    BMS

TC-VAL-UI-013 Verify Page URL Contains
    [Documentation]    Verifies that the page URL contains expected text.
    [Tags]             ui-validation    page
    Verify Page URL Contains    bms.startnow-fr.com

TC-VAL-UI-014 Get Element CSS Property
    [Documentation]    Verifies that CSS property is returned correctly.
    [Tags]             ui-validation    style
    ${display}=    Get Element CSS Property    ${EMAIL_SELECTOR}    display
    Should Not Be Empty    ${display}

TC-VAL-UI-015 Verify Element CSS Property
    [Documentation]    Verifies that submit button has expected display property.
    [Tags]             ui-validation    style
    Verify Element CSS Property    ${SUBMIT_SELECTOR}    display    inline-flex

TC-VAL-UI-016 Verify Element Is Hidden After Submit Error
    [Documentation]    Verifies an element becomes visible after a failed login.
    [Tags]             ui-validation    visibility
    Fill Form Field    ${EMAIL_SELECTOR}    wrong@email.com
    Fill Form Field    ${PASSWORD_SELECTOR}    wrongpassword
    Click Element    ${SUBMIT_SELECTOR}
    Sleep    3s
    Verify Element Is Visible    p.chakra-text.css-1wfsjd5