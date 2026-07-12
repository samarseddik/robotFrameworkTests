*** Settings ***
Documentation    Test cases for QueryLogger keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/FileLogger.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/logging/QueryLogger.robot
Suite Setup      Create Log File    ${LOG_PATH}    ${LOG_FILE}    Query Log
Suite Teardown   Run Keywords
...    Sleep    1s    AND
...    Remove Directory    ${LOG_PATH}    recursive=True

*** Variables ***
${LOG_PATH}      C:/Users/Lenovo/Desktop/robotFrameworkTests/logs
${LOG_FILE}      queries.log

*** Test Cases ***
TC-QL-001 Log Database Query
    [Documentation]    Verifies that a SQL query is logged correctly.
    [Tags]             query-logger    query
    Log Database Query    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM users
    ${result}=    Validate Log File    ${LOG_PATH}    ${LOG_FILE}
    Should Be True    ${result}

TC-QL-002 Log Query Result
    [Documentation]    Verifies that a query result is logged correctly.
    [Tags]             query-logger    query
    Log Query Result    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM users
    ...    row_count=8

TC-QL-003 Log Query Duration
    [Documentation]    Verifies that query duration is logged correctly.
    [Tags]             query-logger    query
    Log Query Duration    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM users    duration=0.3

TC-QL-004 Log Query Success
    [Documentation]    Verifies that a successful query is logged correctly.
    [Tags]             query-logger    query
    Log Query Success    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM users

TC-QL-005 Log Query Failure
    [Documentation]    Verifies that a failed query is logged correctly.
    [Tags]             query-logger    query
    Log Query Failure    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM unknown_table
    ...    error_message=Table does not exist

TC-QL-006 Log Query Parameters
    [Documentation]    Verifies that query parameters are logged correctly.
    [Tags]             query-logger    query
    Log Query Parameters    ${LOG_PATH}    ${LOG_FILE}    SELECT * FROM users WHERE user_id = :id
    ...    user_id=1
    ...    table=users

TC-QL-007 Log Connection Details
    [Documentation]    Verifies that connection details are logged correctly.
    [Tags]             query-logger    connection
    Log Connection Details    ${LOG_PATH}    ${LOG_FILE}
    ...    host=localhost
    ...    port=3306
    ...    database=bms
    ...    driver=mysql

TC-QL-008 Log Transaction Start
    [Documentation]    Verifies that transaction start is logged correctly.
    [Tags]             query-logger    transaction
    Log Transaction Start    ${LOG_PATH}    ${LOG_FILE}    transaction_id=TXN-001

TC-QL-009 Log Transaction End
    [Documentation]    Verifies that transaction end is logged correctly.
    [Tags]             query-logger    transaction
    Log Transaction End    ${LOG_PATH}    ${LOG_FILE}    transaction_id=TXN-001    duration=1.2

TC-QL-010 Log Transaction Rollback
    [Documentation]    Verifies that transaction rollback is logged correctly.
    [Tags]             query-logger    transaction
    Log Transaction Rollback    ${LOG_PATH}    ${LOG_FILE}    transaction_id=TXN-002
    ...    reason=Constraint violation