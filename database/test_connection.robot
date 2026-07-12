*** Settings ***
Documentation    Test cases for database connection keywords.
Resource    C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseConnection.robot

*** Variables ***
${DB_HOST}        localhost
${DB_PORT}        3306
${DB_NAME}        bms
${DB_USER}        root
${DB_PASSWORD}    ${EMPTY}
${DB_DRIVER}      mysql

*** Test Cases ***

TC-CON-001 Verify Database Connection Is Active
    [Documentation]    Verifies that the database connection is established successfully.
    [Tags]             connection    smoke
    Connect To Database With Config
    Verify Database Connection
    Disconnect From Database

TC-CON-002 Verify Database Connection Status
    [Documentation]    Verifies that the connection status is ACTIVE after connecting.
    [Tags]             connection
    Connect To Database With Config
    ${status}=    Get Database Connection Status
    Should Be Equal    ${status}    ACTIVE
    Disconnect From Database

TC-CON-003 Verify Database Disconnection
    [Documentation]    Verifies that the connection status is INACTIVE after disconnecting.
    [Tags]             connection
    Connect To Database With Config
    Disconnect From Database
    ${status}=    Get Database Connection Status
    Should Be Equal    ${status}    INACTIVE

TC-CON-004 Reconfigure And Reconnect With Custom Parameters
    [Documentation]    Overrides connection parameters at runtime and reconnects.
    [Tags]             connection
    Configure Database Connection Parameters
    ...    host=localhost
    ...    port=3306
    ...    database=bms
    ...    user=root
    ...    driver=mysql
    Connect To Database With Config
    Verify Database Connection
    Disconnect From Database