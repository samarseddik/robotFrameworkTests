*** Settings ***
Documentation    Test cases for NavigationKeywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/CommonUI.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ui/NavigationKeywords.robot
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup       Navigate To URL    ${URL}

*** Variables ***
${URL}          https://bms.startnow-fr.com
${BROWSER}      chromium
${HEADLESS}     False

*** Test Cases ***
TC-NAV-001 Navigate To URL
    [Documentation]    Verifies navigation to the BMS URL.
    [Tags]             navigation    url
    Verify URL Contains    bms.startnow-fr.com

TC-NAV-002 Refresh Page
    [Documentation]    Verifies that the page refreshes successfully.
    [Tags]             navigation    page
    Refresh Page
    Verify URL Contains    bms.startnow-fr.com

TC-NAV-003 Get Current URL
    [Documentation]    Verifies that the current URL is returned correctly.
    [Tags]             navigation    url
    ${url}=    Get Current URL
    Should Contain    ${url}    bms.startnow-fr.com

TC-NAV-004 Verify URL Contains
    [Documentation]    Verifies that URL contains expected text.
    [Tags]             navigation    url
    Verify URL Contains    bms.startnow-fr.com

TC-NAV-005 Wait For Page To Load
    [Documentation]    Verifies that the page loads successfully.
    [Tags]             navigation    load
    Wait For Page To Load

TC-NAV-006 Scroll To Bottom
    [Documentation]    Verifies that page scrolls to the bottom.
    [Tags]             navigation    scroll
    Scroll To Bottom

TC-NAV-007 Scroll To Top
    [Documentation]    Verifies that page scrolls back to the top.
    [Tags]             navigation    scroll
    Scroll To Bottom
    Scroll To Top

TC-NAV-008 Scroll By
    [Documentation]    Verifies that page scrolls by a specific amount.
    [Tags]             navigation    scroll
    Scroll By    x=0    y=300
    Scroll By    x=0    y=-300

TC-NAV-009 Go Back And Forward
    [Documentation]    Verifies browser back and forward navigation.
    [Tags]             navigation    history
    Navigate To URL    https://bms.startnow-fr.com
    Go Back
    Go Forward
    Verify URL Contains    bms.startnow-fr.com

TC-NAV-010 Get All Tabs
    [Documentation]    Verifies that all open tabs are returned.
    [Tags]             navigation    tabs
    ${tabs}=    Get All Tabs
    Should Not Be Empty    ${tabs}

TC-NAV-011 Open And Close Tab
    [Documentation]    Verifies that a new tab can be opened and closed.
    [Tags]             navigation    tabs
    Open New Page    ${URL}
    ${tabs}=    Get All Tabs
    Should Be True    ${tabs.__len__()} >= 2
    Close Current Tab

TC-NAV-012 Switch To Tab
    [Documentation]    Verifies switching between tabs.
    [Tags]             navigation    tabs
    Open New Page    ${URL}
    ${tabs}=    Get Page Ids    ALL
    ${first_tab}=    Set Variable    ${tabs}[0]
    ${second_tab}=    Set Variable    ${tabs}[1]
    Switch To Tab    ${first_tab}
    Verify URL Contains    bms.startnow-fr.com
    Switch To Tab    ${second_tab}
    Close Current Tab

TC-NAV-013 Wait For Element To Load
    [Documentation]    Verifies that an element loads on the page.
    [Tags]             navigation    load
    Wait For Element To Load    input[type="email"]

TC-NAV-014 Scroll To Element
    [Documentation]    Verifies scrolling to a specific element.
    [Tags]             navigation    scroll
    Scroll To Element    input[type="email"]