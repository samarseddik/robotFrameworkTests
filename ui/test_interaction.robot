*** Settings ***
Documentation    Test cases for InteractionKeywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/CommonUI.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/NavigationKeywords.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/InteractionKeywords.robot
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup    Run Keywords
...    Browser.Delete All Cookies    AND
...    Navigate To URL    ${URL}


*** Variables ***
${URL}                  https://bms.startnow-fr.com
${BROWSER}              chromium
${HEADLESS}             False
${EMAIL_SELECTOR}       input[type="email"]
${PASSWORD_SELECTOR}    input[type="password"]
${LOGIN_BUTTON}         button[type="submit"]
${EMAIL}                superAdmin@start-now.fr
${PASSWORD}             BMSstart10*

*** Test Cases ***
TC-INT-001 Click Element
    [Documentation]    Verifies that an element can be clicked.
    [Tags]             interaction    click
    Click Element    ${EMAIL_SELECTOR}

TC-INT-002 Type Text
    [Documentation]    Verifies that text can be typed into an element.
    [Tags]             interaction    keyboard
    Type Text    ${EMAIL_SELECTOR}    ${EMAIL}

TC-INT-003 Clear And Type Text
    [Documentation]    Verifies that text can be cleared and retyped.
    [Tags]             interaction    keyboard
    Type Text    ${EMAIL_SELECTOR}    wrong@email.com
    Clear And Type Text    ${EMAIL_SELECTOR}    ${EMAIL}

TC-INT-004 Hover Over Element
    [Documentation]    Verifies that hovering over an element works.
    [Tags]             interaction    mouse
    Hover Over Element    ${EMAIL_SELECTOR}

TC-INT-005 Focus Element
    [Documentation]    Verifies that focus can be set on an element.
    [Tags]             interaction    focus
    Focus Element    ${EMAIL_SELECTOR}

TC-INT-006 Blur Element
    [Documentation]    Verifies that focus can be removed from an element.
    [Tags]             interaction    focus
    Focus Element    ${EMAIL_SELECTOR}
    Blur Element    ${EMAIL_SELECTOR}

TC-INT-007 Press Tab
    [Documentation]    Verifies that Tab key moves focus to next element.
    [Tags]             interaction    keyboard
    Focus Element    ${EMAIL_SELECTOR}
    Press Tab

TC-INT-008 Press Escape
    [Documentation]    Verifies that Escape key works.
    [Tags]             interaction    keyboard
    Press Escape

TC-INT-009 Press Enter
    [Documentation]    Verifies that Enter key works.
    [Tags]             interaction    keyboard
    Type Text    ${EMAIL_SELECTOR}    ${EMAIL}
    Type Text    ${PASSWORD_SELECTOR}    ${PASSWORD}
    Press Enter

TC-INT-010 Wait For Element
    [Documentation]    Verifies that an element becomes visible.
    [Tags]             interaction    wait
    Wait For Element    ${EMAIL_SELECTOR}

TC-INT-011 Wait For Element To Be Enabled
    [Documentation]    Verifies that an element becomes enabled.
    [Tags]             interaction    wait
    Wait For Element To Be Enabled    ${LOGIN_BUTTON}

TC-INT-012 Select Option By Label
    [Documentation]    Verifies selecting an option from dropdown by label.
    [Tags]             interaction    select
    ${dropdown}=    Set Variable    select
    Wait For Element    ${dropdown}
    Select Option By Label    ${dropdown}    superAdmin@start-now.fr

TC-INT-013 Select Option By Index
    [Documentation]    Verifies selecting an option from dropdown by index.
    [Tags]             interaction    select
    ${dropdown}=    Set Variable    select
    Wait For Element    ${dropdown}
    Select Option By Index    ${dropdown}    1

TC-INT-014 Get Selected Option
    [Documentation]    Verifies that selected option value is returned.
    [Tags]             interaction    select
    ${dropdown}=    Set Variable    select
    Wait For Element    ${dropdown}
    Select Option By Index    ${dropdown}    0
    ${value}=    Get Selected Option    ${dropdown}
    Should Not Be Empty    ${value}

TC-INT-015 Login And Wait For Element To Disappear
    [Documentation]    Verifies that login form disappears after successful login.
    [Tags]             interaction    wait
    Type Text    ${EMAIL_SELECTOR}    ${EMAIL}
    Type Text    ${PASSWORD_SELECTOR}    ${PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Wait For Element To Disappear    ${LOGIN_BUTTON}    timeout=15s

TC-INT-016 Double Click Element
    [Documentation]    Verifies that double click works on an element.
    [Tags]             interaction    click
    Double Click Element    ${EMAIL_SELECTOR}

TC-INT-017 Press Key
    [Documentation]    Verifies that a specific key can be pressed.
    [Tags]             interaction    keyboard
    Focus Element    ${EMAIL_SELECTOR}
    Press Key    ${EMAIL_SELECTOR}    a