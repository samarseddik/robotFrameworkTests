*** Settings ***
Documentation    Test cases for VisualTestingKeywords.
Resource         ${KEYWORDS_PATH}/ui/CommonUI.robot
Resource         ${KEYWORDS_PATH}/ui/NavigationKeywords.robot
Resource         ${KEYWORDS_PATH}/ui/VisualTestingKeywords.robot
Suite Setup      Configure Browser Options
Suite Teardown   Close All Browser Sessions
Test Setup       Navigate To URL    ${URL}

*** Variables ***
${URL}                  https://bms.startnow-fr.com
${BROWSER}              chromium
${HEADLESS}             False
${EMAIL_SELECTOR}       input[type="email"]
${SUBMIT_SELECTOR}      button[type="submit"]
${SCREENSHOT_PATH}      ${OUTPUTDIR}/screenshots
${BASELINE_PATH}        ${OUTPUTDIR}/baseline

*** Test Cases ***
TC-VIS-001 Take Full Page Screenshot
    [Documentation]    Verifies that a full page screenshot is taken successfully.
    [Tags]             visual    screenshot
    ${path}=    Take Full Page Screenshot    tc_vis_001.png    ${SCREENSHOT_PATH}
    File Should Exist    ${path}

TC-VIS-002 Take Element Screenshot
    [Documentation]    Verifies that an element screenshot is taken successfully.
    [Tags]             visual    screenshot
    ${path}=    Take Element Screenshot    ${EMAIL_SELECTOR}    tc_vis_002.png    ${SCREENSHOT_PATH}
    File Should Exist    ${path}

TC-VIS-003 Take Viewport Screenshot
    [Documentation]    Verifies that a viewport screenshot is taken successfully.
    [Tags]             visual    screenshot
    ${path}=    Take Viewport Screenshot    tc_vis_003.png    ${SCREENSHOT_PATH}
    File Should Exist    ${path}

TC-VIS-004 Save Baseline Screenshot
    [Documentation]    Verifies that a baseline screenshot is saved successfully.
    [Tags]             visual    baseline
    ${path}=    Save Baseline Screenshot    baseline.png    ${BASELINE_PATH}
    File Should Exist    ${path}

TC-VIS-005 Compare Screenshots
    [Documentation]    Verifies that two screenshots can be compared.
    [Tags]             visual    comparison
    ${baseline}=    Save Baseline Screenshot    compare_baseline.png    ${BASELINE_PATH}
    ${current}=    Take Full Page Screenshot    compare_current.png    ${SCREENSHOT_PATH}
    ${result}=    Compare Screenshots    ${baseline}    ${current}
    Should Be True    ${result}

TC-VIS-006 Verify Page Has Not Changed
    [Documentation]    Verifies that the page matches the baseline screenshot.
    [Tags]             visual    comparison
    Save Baseline Screenshot    baseline.png    ${BASELINE_PATH}
    ${result}=    Verify Page Has Not Changed
    ...    baseline.png    ${BASELINE_PATH}    ${SCREENSHOT_PATH}
    Should Be True    ${result}

TC-VIS-007 Verify Element Is Visible On Screen
    [Documentation]    Verifies that email field is visible within the viewport.
    [Tags]             visual    validation
    Verify Element Is Visible On Screen    ${EMAIL_SELECTOR}

TC-VIS-008 Verify Page Layout
    [Documentation]    Verifies that key login page elements are visible.
    [Tags]             visual    validation
    Verify Page Layout
    ...    ${EMAIL_SELECTOR}
    ...    input[type="password"]
    ...    ${SUBMIT_SELECTOR}

TC-VIS-009 Verify Element Position
    [Documentation]    Verifies that email field is within expected position bounds.
    [Tags]             visual    validation
    Verify Element Position    ${EMAIL_SELECTOR}
    ...    min_x=0    min_y=0
    ...    max_x=1920    max_y=1080

TC-VIS-010 Get Screenshot Path
    [Documentation]    Verifies that screenshot path is returned correctly.
    [Tags]             visual    reporting
    ${path}=    Get Screenshot Path    test.png    ${SCREENSHOT_PATH}
    Should Contain    ${path}    test.png

TC-VIS-011 Save Visual Report
    [Documentation]    Verifies that a visual report is saved with screenshots.
    [Tags]             visual    reporting
    ${report_path}=    Save Visual Report    bms_login    ${SCREENSHOT_PATH}
    Directory Should Exist    ${report_path}