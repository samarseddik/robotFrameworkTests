*** Settings ***
Documentation    Test cases for database validation keywords.
Resource         ${KEYWORDS_PATH}/database/DatabaseConnection.robot
Resource         ${KEYWORDS_PATH}/database/DatabaseCRUD.robot
Resource         ${KEYWORDS_PATH}/database/DatabaseValidation.robot
Suite Setup      Connect To Database With Config
Suite Teardown   Disconnect From Database

*** Variables ***
${DB_HOST}        localhost
${DB_PORT}        3306
${DB_NAME}        bms
${DB_USER}        root
${DB_PASSWORD}    ${EMPTY}
${DB_DRIVER}      mysql

*** Test Cases ***
TC-VAL-001 Verify Record Exists In Users Table
    [Documentation]    Verifies that a known user exists in the database.
    [Tags]             validation
    ${result}=    Verify Record Exists    users    user_name = 'Mouhamed'
    Should Be True    ${result}

TC-VAL-002 Verify Record Does Not Exist In Users Table
    [Documentation]    Verifies that a non-existent user is not in the database.
    [Tags]             validation
    ${result}=    Verify Record Does Not Exist    users    user_name = 'GhostUser'
    Should Be True    ${result}

TC-VAL-003 Verify Column Value
    [Documentation]    Verifies that a specific column has the expected value.
    [Tags]             validation
    ${result}=    Verify Column Value    users    user_id = 1    user_name    StartNow
    Should Be True    ${result}

TC-VAL-004 Verify Table Is Not Empty
    [Documentation]    Verifies that the users table contains at least one record.
    [Tags]             validation
    ${result}=    Verify Table Is Not Empty    users
    Should Be True    ${result}

TC-VAL-005 Verify Table Record Count
    [Documentation]    Verifies the exact number of records in the users table.
    [Tags]             validation
    ${count}=    Count Records In Table    users
    Verify Table Record Count    users    ${count}

TC-VAL-006 Verify Column Exists
    [Documentation]    Verifies that the email column exists in the users table.
    [Tags]             validation
    ${result}=    Verify Column Exists    users    email
    Should Be True    ${result}

TC-VAL-007 Verify Unique Constraint On Email
    [Documentation]    Verifies that a specific email exists only once in the table.
    [Tags]             validation
    ${result}=    Verify Unique Constraint    users    email    mouhamed@start-now.fr
    Should Be True    ${result}

TC-VAL-008 Verify Multiple Column Values
    [Documentation]    Verifies multiple column values for a specific user.
    [Tags]             validation
    ${where}=    Set Variable    user_id = 2
    ${result}=    Verify Multiple Column Values    users    ${where}
    ...    user_name=Mouhamed
    ...    email=mouhamed@start-now.fr
    Should Be True    ${result}

TC-VAL-009 Verify Data Type Of Email Column
    [Documentation]    Verifies that the email column has the correct data type.
    [Tags]             validation
    ${result}=    Verify Data Type    users    email    varchar
    Should Be True    ${result}

TC-VAL-010 Verify Foreign Key Relationship
    [Documentation]    Verifies that a user belongs to an existing building.
    [Tags]             validation
    ${result}=    Verify Foreign Key Relationship    buildings    1    users    building_id    1    building_id
    Should Be True    ${result}