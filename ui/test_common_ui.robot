*** Settings ***
Documentation    Test cases for CommonUI keywords.
Resource    ${KEYWORDS_PATH}/ui/CommonUI.robot
Library          Browser
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup       Open New Page    ${URL}

*** Variables ***
${URL}              https://bms.startnow-fr.com
${BROWSER}          chromium
${HEADLESS}         False
${SCREENSHOT_PATH}  ${OUTPUTDIR}/screenshots
*** Test Cases ***
TC-UI-001 Open Browser Session
    [Documentation]    Verifies that a browser session opens successfully.
    [Tags]             common-ui    browser
    ${browser}=    Open Browser Session    ${BROWSER}    ${HEADLESS}
    Should Not Be Empty    ${browser}

TC-UI-002 Open New Page
    [Documentation]    Verifies that a new page opens successfully.
    [Tags]             common-ui    page
    Open New Page    ${URL}
    ${url}=    Get Current Page URL
    Should Contain    ${url}    bms.startnow-fr.com

TC-UI-003 Get Current Page Title
    [Documentation]    Verifies that the page title is returned correctly.
    [Tags]             common-ui    page
    ${title}=    Get Current Page Title
    Should Not Be Empty    ${title}
    Log    Page title: ${title}

TC-UI-004 Get Current Page URL
    [Documentation]    Verifies that the current URL is returned correctly.
    [Tags]             common-ui    page
    ${url}=    Get Current Page URL
    Should Contain    ${url}    bms.startnow-fr.com

TC-UI-005 Take Page Screenshot
    [Documentation]    Verifies that a screenshot is taken successfully.
    [Tags]             common-ui    screenshot
    ${path}=    Take Page Screenshot    ${SCREENSHOT_PATH}    tc_ui_005.png
    Should Not Be Empty    ${path}

TC-UI-006 Get Browser Version
    [Documentation]    Verifies that browser version is returned.
    [Tags]             common-ui    browser
    ${version}=    Get Browser Version
    Log    Browser version: ${version}

TC-UI-007 Get Browser Cookies
    [Documentation]    Verifies that cookies are retrieved from the browser.
    [Tags]             common-ui    cookies
    ${cookies}=    Get Browser Cookies
    Log    Cookies: ${cookies}

TC-UI-008 Set Browser Cookie
    [Documentation]    Verifies that a cookie can be set in the browser.
    [Tags]             common-ui    cookies
    Set Browser Cookie    test_cookie    test_value    url=${URL}
    ${cookies}=    Get Browser Cookies
    Log    Cookies after set: ${cookies}

TC-UI-009 Clear Browser Cookies
    [Documentation]    Verifies that cookies are cleared successfully.
    [Tags]             common-ui    cookies
    Clear Browser Cookies

TC-UI-010 Create And Close Browser Context
    [Documentation]    Verifies that a browser context can be created and closed.
    [Tags]             common-ui    context
    Create Browser Context    1280    720
    Open New Page    ${URL}
    Close Browser Context

TC-UI-011 Close Current Page
    [Documentation]    Verifies that the current page can be closed.
    [Tags]             common-ui    page
    Open New Page    ${URL}
    Close Current Page

TC-UI-012 Clear Browser Cache
    [Documentation]    Verifies that browser cache is cleared by creating fresh context.
    [Tags]             common-ui    browser
    Clear Browser Cache
    Open New Page    ${URL}
    ${url}=    Get Current Page URL
    Should Contain    ${url}    bms.startnow-fr.com