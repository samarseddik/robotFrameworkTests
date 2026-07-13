*** Settings ***
Documentation    Test cases for FileLogger keywords.
Resource    ${KEYWORDS_PATH}/logging/FileLogger.robot
Resource    ${KEYWORDS_PATH}/logging/ExecutionLogger.robot
Suite Teardown   Remove Directory    ${LOG_PATH}    recursive=True


*** Variables ***
${LOG_PATH}      C:/Users/Lenovo/Desktop/robotFrameworkTests/logs
${LOG_FILE}      execution.log



*** Test Cases ***
TC-FL-001 Create Log File
    [Documentation]    Verifies that a log file is created successfully.
    [Tags]             file-logger    create
    ${path}=    Create Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Not Be Empty    ${path}

TC-FL-002 Append To Log File
    [Documentation]    Verifies that a message is appended to the log file.
    [Tags]             file-logger    write
    Append To Log File    ${LOG_PATH}    ${LOG_FILE}    This is a test message

TC-FL-003 Get Log File Path
    [Documentation]    Verifies that the correct path is returned.
    [Tags]             file-logger    read
    ${path}=    Get Log File Path    ${LOG_PATH}    ${LOG_FILE}
    Should Be Equal    ${path}    ${LOG_PATH}/${LOG_FILE}

TC-FL-004 Validate Log File
    [Documentation]    Verifies that the log file exists and is not empty.
    [Tags]             file-logger    validate
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-FL-005 Get Log File Size
    [Documentation]    Verifies that the log file size is greater than 0.
    [Tags]             file-logger    read
    ${size}=    Get Log File Size    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${size} > 0

TC-FL-006 Backup Log File
    [Documentation]    Verifies that a backup of the log file is created.
    [Tags]             file-logger    backup
    ${backup}=    Backup Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Not Be Empty    ${backup}

TC-FL-007 Export Log To JSON
    [Documentation]    Verifies that the log file is exported to JSON.
    [Tags]             file-logger    export
    ${json_path}=    Export Log To JSON    ${LOG_PATH}    ${LOG_FILE}
    Should Not Be Empty    ${json_path}

TC-FL-008 Export Log To CSV
    [Documentation]    Verifies that the log file is exported to CSV.
    [Tags]             file-logger    export
    ${csv_path}=    Export Log To CSV    ${LOG_PATH}    ${LOG_FILE}
    Should Not Be Empty    ${csv_path}

TC-FL-009 Generate Execution Report
    [Documentation]    Verifies that an execution report is generated.
    [Tags]             file-logger    report
    ${report}=    Generate Execution Report    ${LOG_PATH}
    Should Not Be Empty    ${report}

TC-FL-010 Archive Log File
    [Documentation]    Verifies that the log file is archived.
    [Tags]             file-logger    archive
    ${archived}=    Archive Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Not Be Empty    ${archived}

TC-FL-011 Clear Log File
    [Documentation]    Verifies that the log file is cleared.
    [Tags]             file-logger    clear
    Create Log File    ${LOG_PATH}    ${LOG_FILE}
    ${result}=    Clear Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-FL-012 Delete Old Logs
    [Documentation]    Verifies that old log files are deleted.
    [Tags]             file-logger    delete
    ${count}=    Delete Old Logs    ${LOG_PATH}    0
    Should Be True    ${count} >= 0