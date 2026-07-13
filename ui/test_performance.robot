*** Settings ***
Documentation    Test cases for PerformanceKeywords.
Resource         ${KEYWORDS_PATH}/ui/CommonUI.robot
Resource         ${KEYWORDS_PATH}/ui/NavigationKeywords.robot
Resource         ${KEYWORDS_PATH}/ui/PerformanceKeywords.robot
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup       Navigate To URL    ${URL}

*** Variables ***
${URL}                  https://bms.startnow-fr.com
${BROWSER}              chromium
${HEADLESS}             False
${MAX_LOAD_TIME}        10000
${SLOW_THRESHOLD}       2000

*** Test Cases ***
TC-PERF-001 Get Page Load Time    
    [Documentation]    Verifies that page load time is returned correctly.
    [Tags]             performance    metrics
    ${load_time}=    Get Page Load Time
    Should Be True    ${load_time} > 0
    Log    Page load time: ${load_time}ms

TC-PERF-002 Get DOM Content Loaded Time
    [Documentation]    Verifies that DOM content loaded time is returned.
    [Tags]             performance    metrics
    ${dom_time}=    Get DOM Content Loaded Time
    Should Be True    ${dom_time} > 0
    Log    DOM content loaded time: ${dom_time}ms

TC-PERF-003 Get First Contentful Paint
    [Documentation]    Verifies that First Contentful Paint metric is returned.
    [Tags]             performance    metrics
    ${fcp}=    Get First Contentful Paint
    Should Not Be Empty    ${fcp}
    Log    First Contentful Paint: ${fcp}

TC-PERF-004 Get Largest Contentful Paint
    [Documentation]    Verifies that Largest Contentful Paint metric is returned.
    [Tags]             performance    metrics
    ${lcp}=    Get Largest Contentful Paint
    Should Not Be Empty    ${lcp}
    Log    Largest Contentful Paint: ${lcp}

TC-PERF-005 Get Resource Load Times
    [Documentation]    Verifies that resource load times are returned.
    [Tags]             performance    resources
    ${resources}=    Get Resource Load Times
    Should Not Be Empty    ${resources}
    Log    Resources: ${resources}

TC-PERF-006 Get Slow Resources
    [Documentation]    Verifies that slow resources are detected correctly.
    [Tags]             performance    resources
    ${slow}=    Get Slow Resources    ${SLOW_THRESHOLD}
    Log    Slow resources: ${slow}

TC-PERF-007 Verify Page Load Time
    [Documentation]    Verifies that page load time is within acceptable limit.
    [Tags]             performance    validation
    Verify Page Load Time    ${MAX_LOAD_TIME}

TC-PERF-008 Verify Resource Load Time
    [Documentation]    Verifies that the login API resource loads within limit.
    [Tags]             performance    validation
    Verify Resource Load Time    bms.startnow-fr.com    ${MAX_LOAD_TIME}

TC-PERF-009 Start And Stop Performance Timer
    [Documentation]    Verifies that performance timer works correctly.
    [Tags]             performance    timer
    ${start}=    Start Performance Timer    page_load
    Sleep    1s
    ${elapsed}=    Stop Performance Timer    page_load
    Should Be True    ${elapsed} >= 1

TC-PERF-010 Get Elapsed Time
    [Documentation]    Verifies that elapsed time is returned after stopping timer.
    [Tags]             performance    timer
    Start Performance Timer    test_timer
    Sleep    1s
    Stop Performance Timer    test_timer
    ${elapsed}=    Get Elapsed Time    test_timer
    Should Be True    ${elapsed} >= 1

TC-PERF-011 Measure Navigation Time
    [Documentation]    Measures and verifies navigation time to BMS.
    [Tags]             performance    timer
    Start Performance Timer    navigation
    Navigate To URL    ${URL}
    ${elapsed}=    Stop Performance Timer    navigation
    Should Be True    ${elapsed} >= 0
    Log    Navigation time: ${elapsed}s