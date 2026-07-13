*** Settings ***
Documentation    Test cases for FormKeywords.
Resource    ${KEYWORDS_PATH}/ui/CommonUI.robot
Resource    ${KEYWORDS_PATH}/ui/NavigationKeywords.robot
Resource    ${KEYWORDS_PATH}/ui/InteractionKeywords.robot
Resource    ${KEYWORDS_PATH}/ui/FormKeywords.robot
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
${WRONG_EMAIL}          wrong@email.com
${WRONG_PASSWORD}       wrongpassword
${ERROR_SELECTOR}       .chakra-alert
${DASHBOARD_SELECTOR}   .chakra-button.css-4vyskk
${SCREENSHOT_PATH}      ${OUTPUTDIR}/screenshots
*** Test Cases ***
TC-FORM-001 Fill Form Field
    [Documentation]    Verifies that a form field can be filled.
    [Tags]             form    fill
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    Verify Form Field Value    ${EMAIL_SELECTOR}    ${EMAIL}

TC-FORM-002 Clear Form Field
    [Documentation]    Verifies that a form field can be cleared.
    [Tags]             form    fill
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    Clear Form Field    ${EMAIL_SELECTOR}
    Verify Form Field Is Empty    ${EMAIL_SELECTOR}

TC-FORM-003 Get Form Field Value
    [Documentation]    Verifies that form field value is returned correctly.
    [Tags]             form    fill
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    ${value}=    Get Form Field Value    ${EMAIL_SELECTOR}
    Should Be Equal    ${value}    ${EMAIL}

TC-FORM-004 Verify Form Field Value
    [Documentation]    Verifies that form field contains expected value.
    [Tags]             form    validation
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    Verify Form Field Value    ${EMAIL_SELECTOR}    ${EMAIL}

TC-FORM-005 Verify Form Field Is Empty
    [Documentation]    Verifies that an empty form field is detected.
    [Tags]             form    validation
    Clear Form Field    ${EMAIL_SELECTOR}
    Verify Form Field Is Empty    ${EMAIL_SELECTOR}

TC-FORM-006 Verify Form Field Is Required
    [Documentation]    Verifies that email field is required by submitting empty form.
    [Tags]             form    validation
    Clear Form Field    ${EMAIL_SELECTOR}
    Clear Form Field    ${PASSWORD_SELECTOR}
    Verify Form Field Is Required
    ...    ${EMAIL_SELECTOR}
    ...    ${SUBMIT_SELECTOR}
    ...    div.css-162t4e

TC-FORM-007 Verify Form Field Is Visible
    [Documentation]    Verifies that form fields are visible.
    [Tags]             form    state
    Verify Form Field Is Visible    ${EMAIL_SELECTOR}
    Verify Form Field Is Visible    ${PASSWORD_SELECTOR}
    Verify Form Field Is Visible    ${SUBMIT_SELECTOR}

TC-FORM-008 Verify Form Field Is Enabled
    [Documentation]    Verifies that form fields are enabled.
    [Tags]             form    state
    Verify Form Field Is Enabled    ${EMAIL_SELECTOR}
    Verify Form Field Is Enabled    ${PASSWORD_SELECTOR}
    Verify Form Field Is Enabled    ${SUBMIT_SELECTOR}

TC-FORM-009 Get Form Field State
    [Documentation]    Verifies that form field state is returned correctly.
    [Tags]             form    state
    ${state}=    Get Form Field State    ${EMAIL_SELECTOR}
    Should Be Equal    ${state}    enabled-visible

TC-FORM-010 Fill Form With Data
    [Documentation]    Verifies that multiple form fields can be filled at once.
    [Tags]             form    fill
    Fill Form With Data
    ...    ${EMAIL_SELECTOR}=${EMAIL}
    ...    ${PASSWORD_SELECTOR}=${PASSWORD}
    Verify Form Field Value    ${EMAIL_SELECTOR}    ${EMAIL}
    Verify Form Field Value    ${PASSWORD_SELECTOR}    ${PASSWORD}

TC-FORM-011 Clear All Form Fields
    [Documentation]    Verifies that multiple form fields can be cleared at once.
    [Tags]             form    fill
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    Fill Form Field    ${PASSWORD_SELECTOR}    ${PASSWORD}
    Clear All Form Fields    ${EMAIL_SELECTOR}    ${PASSWORD_SELECTOR}
    Verify Form Field Is Empty    ${EMAIL_SELECTOR}
    Verify Form Field Is Empty    ${PASSWORD_SELECTOR}

TC-FORM-012 Get All Form Field Values
    [Documentation]    Verifies that all form field values are returned as dictionary.
    [Tags]             form    fill
    Fill Form Field    ${EMAIL_SELECTOR}    ${EMAIL}
    ${values}=    Get All Form Field Values    ${EMAIL_SELECTOR}
    Should Not Be Empty    ${values}

TC-FORM-013 Fill Login Form
    [Documentation]    Verifies that login form is filled correctly.
    [Tags]             form    login
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Verify Form Field Value    ${EMAIL_SELECTOR}    ${EMAIL}

TC-FORM-014 Submit Login Form
    [Documentation]    Verifies that login form can be submitted.
    [Tags]             form    login
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Submit Login Form    ${SUBMIT_SELECTOR}
    Wait For Load State    networkidle

TC-FORM-015 Verify Login Success
    [Documentation]    Verifies successful login redirects to dashboard.
    [Tags]             form    login
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Take Page Screenshot    ${SCREENSHOT_PATH}    before_submit.png
    Submit Login Form    ${SUBMIT_SELECTOR}
    Sleep    3s
    Take Page Screenshot    ${SCREENSHOT_PATH}    after_submit.png
    Verify URL Contains    dashboard
TC-FORM-016 Verify Login Failure
    [Documentation]    Verifies that wrong credentials show error message.
    [Tags]             form    login
    Fill Login Form    ${WRONG_EMAIL}    ${WRONG_PASSWORD}
    Submit Login Form    ${SUBMIT_SELECTOR}
    Sleep    3s
    Wait For Elements State    p.chakra-text.css-1wfsjd5    visible    timeout=10s
    ${text}=    Get Text    p.chakra-text.css-1wfsjd5
    Should Contain    ${text}    Invalid email address or incorrect password

TC-FORM-017 Submit Form
    [Documentation]    Verifies that form can be submitted via submit keyword.
    [Tags]             form    submit
    Fill Login Form    ${EMAIL}    ${PASSWORD}
    Submit Form    ${SUBMIT_SELECTOR}
    Wait For Load State    networkidle    timeout=15s
    Sleep    3s
    Verify URL Contains    dashboard