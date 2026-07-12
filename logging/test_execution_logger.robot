*** Settings ***
Documentation    Test cases for ExecutionLogger keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/FileLogger.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/ExecutionLogger.robot
Suite Setup      Start Execution Logging    ${LOG_PATH}
# Suite Teardown   Run Keywords
# ...    Stop Execution Logging    ${LOG_PATH}    AND
# ...    Remove Directory    ${LOG_PATH}    recursive=True

*** Variables ***
${LOG_PATH}      C:/Users/Lenovo/Desktop/robotFrameworkTests/logs
${LOG_FILE}      execution.log

*** Test Cases ***
TC-EL-001 Format Timestamp
    [Documentation]    Verifies that a timestamp is returned in the correct format.
    [Tags]             execution-logger    timestamp
    ${timestamp}=    Format Timestamp
    Should Match Regexp    ${timestamp}    \\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}

TC-EL-002 Store And Get Start Time
    [Documentation]    Verifies that start time is stored and retrieved correctly.
    [Tags]             execution-logger    timestamp
    ${start}=    Store Start Time
    ${retrieved}=    Get Execution Start Time
    Should Be Equal    ${start}    ${retrieved}

TC-EL-003 Store And Get End Time
    [Documentation]    Verifies that end time is stored and retrieved correctly.
    [Tags]             execution-logger    timestamp
    ${end}=    Store End Time
    ${retrieved}=    Get Execution End Time
    Should Be Equal    ${end}    ${retrieved}

TC-EL-004 Calculate Execution Duration
    [Documentation]    Verifies that duration is calculated correctly.
    [Tags]             execution-logger    timestamp
    ${start}=    Store Start Time
    ${end}=    Store End Time
    ${duration}=    Calculate Execution Duration    ${start}    ${end}
    Should Be True    ${duration} >= 0

TC-EL-005 Log Duration
    [Documentation]    Verifies that duration is logged to the file.
    [Tags]             execution-logger    timestamp
    Log Duration    ${LOG_PATH}    ${LOG_FILE}    TC-EL-005    1.5
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-EL-006 Enable And Disable Logging
    [Documentation]    Verifies that logging can be enabled and disabled.
    [Tags]             execution-logger    control
    Enable Logging
    Disable Logging
    Enable Logging

TC-EL-007 Set And Get Log Level
    [Documentation]    Verifies that log level can be set and retrieved.
    [Tags]             execution-logger    control
    Set Log Level    DEBUG
    ${level}=    Get Log Level
    Should Be Equal    ${level}    DEBUG
    Set Log Level    INFO

TC-EL-008 Log Suite Setup Start And End
    [Documentation]    Verifies suite setup start and end are logged.
    [Tags]             execution-logger    suite
    Log Suite Setup Start    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    Log Suite Setup End    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-EL-009 Log Suite Teardown Start And End
    [Documentation]    Verifies suite teardown start and end are logged.
    [Tags]             execution-logger    suite
    Log Suite Teardown Start    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    Log Suite Teardown End    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-EL-010 Log Suite Summary
    [Documentation]    Verifies suite summary is logged correctly.
    [Tags]             execution-logger    suite
    Log Suite Summary    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    ...    total=10    passed=9    failed=1

TC-EL-011 Log Suite Statistics
    [Documentation]    Verifies suite statistics are logged correctly.
    [Tags]             execution-logger    suite
    Log Suite Statistics    ${LOG_PATH}    ${LOG_FILE}    TestSuite
    ...    total=10    passed=9    failed=1    skipped=0    duration=5.5

TC-EL-012 Log Test Setup Start And End
    [Documentation]    Verifies test setup start and end are logged.
    [Tags]             execution-logger    test
    Log Test Setup Start    ${LOG_PATH}    ${LOG_FILE}
    Log Test Setup End    ${LOG_PATH}    ${LOG_FILE}

TC-EL-013 Log Test Teardown Start And End
    [Documentation]    Verifies test teardown start and end are logged.
    [Tags]             execution-logger    test
    Log Test Teardown Start    ${LOG_PATH}    ${LOG_FILE}
    Log Test Teardown End    ${LOG_PATH}    ${LOG_FILE}

TC-EL-014 Log Test Duration
    [Documentation]    Verifies test duration is logged correctly.
    [Tags]             execution-logger    test
    Log Test Duration    ${LOG_PATH}    ${LOG_FILE}    duration=2.3

TC-EL-015 Log Test Summary
    [Documentation]    Verifies test summary is logged correctly.
    [Tags]             execution-logger    test
    Log Test Summary    ${LOG_PATH}    ${LOG_FILE}    status=PASS    duration=2.3

TC-EL-016 Log Test Error
    [Documentation]    Verifies test error is logged correctly.
    [Tags]             execution-logger    test
    Log Test Error    ${LOG_PATH}    ${LOG_FILE}    error_message=Something went wrong

TC-EL-017 Log Keyword Arguments
    [Documentation]    Verifies keyword arguments are logged correctly.
    [Tags]             execution-logger    keyword
    Log Keyword Arguments    ${LOG_PATH}    ${LOG_FILE}    Read Records From Table    users    user_id=1

TC-EL-018 Log Keyword Result
    [Documentation]    Verifies keyword result is logged correctly.
    [Tags]             execution-logger    keyword
    Log Keyword Result    ${LOG_PATH}    ${LOG_FILE}    Read Records From Table    result=10 records

TC-EL-019 Log Keyword Success
    [Documentation]    Verifies keyword success is logged correctly.
    [Tags]             execution-logger    keyword
    Log Keyword Success    ${LOG_PATH}    ${LOG_FILE}    Read Records From Table

TC-EL-020 Log Keyword Failure
    [Documentation]    Verifies keyword failure is logged correctly.
    [Tags]             execution-logger    keyword
    Log Keyword Failure    ${LOG_PATH}    ${LOG_FILE}    Read Records From Table
    ...    error_message=Table not found

TC-EL-021 Log Keyword Duration
    [Documentation]    Verifies keyword duration is logged correctly.
    [Tags]             execution-logger    keyword
    Log Keyword Duration    ${LOG_PATH}    ${LOG_FILE}    Read Records From Table    duration=0.5

TC-EL-022 Capture Keyword Error Message
    [Documentation]    Verifies that error message is captured without failing.
    [Tags]             execution-logger    keyword
    ${error}=    Capture Keyword Error Message    Should Be Equal    1    2
    Should Not Be Empty    ${error}

TC-EL-023 Get And Log Execution Status
    [Documentation]    Verifies execution status is retrieved and logged.
    [Tags]             execution-logger    status
    Log Execution Status    ${LOG_PATH}    ${LOG_FILE}

TC-EL-024 Update Execution Status
    [Documentation]    Verifies execution status update is logged.
    [Tags]             execution-logger    status
    Update Execution Status    ${LOG_PATH}    ${LOG_FILE}    PASS    All tests passed

TC-EL-025 Log Failure Reason
    [Documentation]    Verifies failure reason is logged correctly.
    [Tags]             execution-logger    status
    Log Failure Reason    ${LOG_PATH}    ${LOG_FILE}    Database connection timeout

TC-EL-026 Log Pass Message
    [Documentation]    Verifies pass message is logged correctly.
    [Tags]             execution-logger    status
    Log Pass Message    ${LOG_PATH}    ${LOG_FILE}    All validations passed

TC-EL-027 Log Skipped Test
    [Documentation]    Verifies skipped test is logged correctly.
    [Tags]             execution-logger    status
    Log Skipped Test    ${LOG_PATH}    ${LOG_FILE}    reason=Database not available

TC-EL-028 Log Debug Message
    [Documentation]    Verifies debug message is logged when level is DEBUG.
    [Tags]             execution-logger    message
    Set Log Level    DEBUG
    Log Debug Message   ${LOG_PATH}    ${LOG_FILE}    This is a debug message
    Set Log Level    INFO

TC-EL-029 Log Error Message
    [Documentation]    Verifies error message is logged correctly.
    [Tags]             execution-logger    message
    Log Error Message    ${LOG_PATH}    ${LOG_FILE}    This is an error message

TC-EL-030 Log Critical Message
    [Documentation]    Verifies critical message is logged correctly.
    [Tags]             execution-logger    message
    Log Critical Message    ${LOG_PATH}    ${LOG_FILE}    This is a critical message

TC-EL-031 Log Test Step
    [Documentation]    Verifies test step is logged correctly.
    [Tags]             execution-logger    message
    Log Test Step    ${LOG_PATH}    ${LOG_FILE}    Connecting to database

TC-EL-032 Log Validation Result
    [Documentation]    Verifies validation step is logged correctly.
    [Tags]             execution-logger    message
    Log Validation Result    ${LOG_PATH}    ${LOG_FILE}    Verify user exists
    ...    expected=Mouhamed    actual=Mouhamed

TC-EL-033 Clear Execution Log
    [Documentation]    Verifies execution log is cleared successfully.
    [Tags]             execution-logger    control
    ${result}=    Clear Execution Log    ${LOG_PATH}
    Should Be True    ${result}
    # RETURN ${result}

TC-EL-034 Archive Execution Log
    [Documentation]    Verifies execution log is archived successfully.
    [Tags]             execution-logger    control
    Append To Log File    ${LOG_PATH}    ${LOG_FILE}    Test entry before archive
    ${archived}=    Archive Execution Log    ${LOG_PATH}
    Should Not Be Empty    ${archived}