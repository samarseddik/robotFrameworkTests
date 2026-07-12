*** Settings ***
Documentation    Test cases for MultiContextKeywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/CommonUI.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/NavigationKeywords.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/MultiContextKeywords.robot
Suite Setup      Open Browser Session
Suite Teardown   Close All Browser Sessions

*** Variables ***
${URL}          https://bms.startnow-fr.com
${BROWSER}      chromium
${HEADLESS}     False

*** Test Cases ***
TC-MC-001 Create New Browser Context
    [Documentation]    Verifies that a new browser context can be created.
    [Tags]             multi-context    context
    ${context_id}=    Create New Browser Context
    Should Not Be Empty    ${context_id}

TC-MC-002 Switch To Context
    [Documentation]    Verifies switching between browser contexts.
    [Tags]             multi-context    context
    ${context_1}=    Create New Browser Context
    ${context_2}=    Create New Browser Context
    Switch To Context    ${context_1}
    Switch To Context    ${context_2}

TC-MC-003 Get All Contexts
    [Documentation]    Verifies that all browser contexts can be retrieved.
    [Tags]             multi-context    context
    Create New Browser Context
    ${contexts}=    Get All Contexts
    Should Not Be Empty    ${contexts}

TC-MC-004 Close Specific Context
    [Documentation]    Verifies that a specific context can be closed.
    [Tags]             multi-context    context
    ${context_id}=    Create New Browser Context
    Close Specific Context    ${context_id}

TC-MC-005 Create User Session
    [Documentation]    Verifies that a user session can be created.
    [Tags]             multi-context    user
    ${context_id}=    Create User Session    user1    ${URL}
    Should Not Be Empty    ${context_id}

TC-MC-006 Switch To User Session
    [Documentation]    Verifies switching between user sessions.
    [Tags]             multi-context    user
    Create User Session    user1    ${URL}
    Create User Session    user2    ${URL}
    Switch To User Session    user1
    Switch To User Session    user2

TC-MC-007 Close User Session
    [Documentation]    Verifies that a user session can be closed.
    [Tags]             multi-context    user
    Create User Session    user3    ${URL}
    Close User Session    user3

TC-MC-008 Open Link In New Tab
    [Documentation]    Verifies that a link can be opened in a new tab.
    [Tags]             multi-context    tabs
    Create New Browser Context
    Open New Page    ${URL}
    ${page_id}=    Open Link In New Tab    ${URL}
    Should Not Be Empty    ${page_id}

TC-MC-009 Get Tab Count
    [Documentation]    Verifies that tab count is returned correctly.
    [Tags]             multi-context    tabs
    Create New Browser Context
    Open New Page    ${URL}
    ${count}=    Get Tab Count
    Should Be True    ${count} >= 1

TC-MC-010 Verify Tab Count
    [Documentation]    Verifies that tab count matches expected number.
    [Tags]             multi-context    tabs
    Create New Browser Context
    Open New Page    ${URL}
    ${count}=    Get Tab Count
    Verify Tab Count    ${count}

TC-MC-011 Verify Contexts Are Isolated
    [Documentation]    Verifies that two contexts do not share session data.
    [Tags]             multi-context    isolation
    ${context_1}=    Create New Browser Context
    Open New Page    ${URL}
    Set Browser Cookie    test_cookie_1    value1    url=${URL}

    ${context_2}=    Create New Browser Context
    Open New Page    ${URL}

    Verify Contexts Are Isolated    ${context_1}    ${context_2}

TC-MC-012 Get Context Storage State
    [Documentation]    Verifies that storage state can be retrieved.
    [Tags]             multi-context    storage
    Create New Browser Context
    Open New Page    ${URL}
    ${state_file}=    Get Context Storage State
    Should Not Be Empty    ${state_file}

TC-MC-013 Close All User Sessions
    [Documentation]    Verifies that all user sessions can be closed at once.
    [Tags]             multi-context    user
    Create User Session    user4    ${URL}
    Create User Session    user5    ${URL}
    Close All User Sessions