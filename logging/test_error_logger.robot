*** Settings ***
Documentation    Test cases for ErrorLogger keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/FileLogger.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/ErrorLogger.robot
Suite Setup      Create Log File    ${LOG_PATH}    ${LOG_FILE}    Error Log
Suite Teardown   Run Keywords
...    Sleep    1s    AND
...    Remove Directory    ${LOG_PATH}    recursive=True

*** Variables ***
${LOG_PATH}      C:/Users/Lenovo/Desktop/robotFrameworkTests/logs
${LOG_FILE}      errors.log

*** Test Cases ***
TC-ERR-001 Log Error Details
    [Documentation]    Verifies that error details are logged correctly.
    [Tags]             error-logger    error
    Log Error Details    ${LOG_PATH}    ${LOG_FILE}
    ...    error_type=ValueError    error_message=Invalid value provided
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-002 Log Exception
    [Documentation]    Verifies that a full exception with stack trace is logged.
    [Tags]             error-logger    error
    Log Exception    ${LOG_PATH}    ${LOG_FILE}
    ...    exception_type=RuntimeError
    ...    exception_message=Something went wrong
    ...    stack_trace=File test.py line 42 in run_test
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-003 Log Assertion Error
    [Documentation]    Verifies that an assertion error with expected vs actual is logged.
    [Tags]             error-logger    error
    Log Assertion Error    ${LOG_PATH}    ${LOG_FILE}
    ...    assertion=Verify user name
    ...    expected=Mouhamed
    ...    actual=Mohamed
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-004 Log Connection Error
    [Documentation]    Verifies that a database connection error is logged.
    [Tags]             error-logger    error
    Log Connection Error    ${LOG_PATH}    ${LOG_FILE}
    ...    host=localhost
    ...    database=bms
    ...    error_message=Could not connect to database
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-005 Log Timeout Error
    [Documentation]    Verifies that a timeout error is logged correctly.
    [Tags]             error-logger    error
    Log Timeout Error    ${LOG_PATH}    ${LOG_FILE}
    ...    operation=Execute Query
    ...    timeout=30
    ...    unit=s
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-006 Log Warning Message
    [Documentation]    Verifies that a warning message is logged correctly.
    [Tags]             error-logger    warning
    Log Warning Message    ${LOG_PATH}    ${LOG_FILE}
    ...    warning_message=Database response time is slow
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-007 Log Error Summary
    [Documentation]    Verifies that an error summary is logged at the end.
    [Tags]             error-logger    summary
    Log Error Summary    ${LOG_PATH}    ${LOG_FILE}
    ...    total_errors=3
    ...    total_warnings=1
    ...    suite_name=BMS Test Suite
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-008 Capture And Log Error
    [Documentation]    Verifies that a keyword error is captured and logged without failing.
    [Tags]             error-logger    capture
    ${error}=    Capture And Log Error    ${LOG_PATH}    ${LOG_FILE}
    ...    Should Be Equal    1    2
    Should Not Be Empty    ${error}

TC-ERR-009 Log Recovery Action
    [Documentation]    Verifies that a recovery action is logged correctly.
    [Tags]             error-logger    recovery
    Log Recovery Action    ${LOG_PATH}    ${LOG_FILE}
    ...    error_message=Connection lost
    ...    recovery_action=Reconnected to database after 3 retries
    ...    status=SUCCESS
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-ERR-010 Log Critical Error
    [Documentation]    Verifies that a critical error is logged correctly.
    [Tags]             error-logger    critical
    Log Critical Error    ${LOG_PATH}    ${LOG_FILE}
    ...    error_message=Unrecoverable system failure
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}