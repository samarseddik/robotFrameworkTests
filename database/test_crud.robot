*** Settings ***
Documentation    Test cases for CRUD operation keywords.
Resource    C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseConnection.robot
Resource    C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseCRUD.robot
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

TC-CRUD-001 Read All Records From Users Table
    [Documentation]    Reads all records from the users table.
    [Tags]             crud    read
    ${records}=    Read Records From Table    users
    Should Not Be Empty    ${records}
    Log    ${records}

TC-CRUD-002 Read Records With WHERE Clause
    [Documentation]    Reads filtered records from users table.
    [Tags]             crud    read
    ${records}=    Read Records From Table    users    user_id = 1
    Should Not Be Empty    ${records}
    Log    ${records}

TC-CRUD-003 Read Record By Id
    [Documentation]    Reads a single record by its primary key.
    [Tags]             crud    read
    ${record}=    Read Record By Id    users    1    user_id
    Should Not Be Equal    ${record}    ${None}
    Log    ${record}

TC-CRUD-004 Count Records In Users Table
    [Documentation]    Counts all records in the users table.
    [Tags]             crud    read
    ${count}=    Count Records In Table    users
    Should Be True    ${count} > 0
    Log    Total users: ${count}

TC-CRUD-005 Execute Custom Query
    [Documentation]    Executes a custom SELECT query on users table.
    [Tags]             crud    read
    ${results}=    Execute Custom Query    SELECT * FROM users LIMIT 5
    Should Not Be Empty    ${results}
    Log    ${results}

TC-CRUD-006 Create A New User
    [Documentation]    Creates a new test user in the users table.
    [Tags]             crud    create
    ${result}=    Create Record In Table    users
    ...    user_id=99
    ...    building_id=1
    ...    user_type=T
    ...    user_role=0
    ...    user_name=TestUser
    ...    email=testuser@test.com
    ...    user_tel=+21600000000
    ...    password=testpass
    Should Be True    ${result}
    Log    User created successfully

TC-CRUD-007 Update The Created User
    [Documentation]    Updates the name of the test user created in TC-CRUD-006.
    [Tags]             crud    update
    ${result}=    Update Record By Id    users    99    user_id
    ...    user_name=UpdatedUser
    ...    email=updateduser@test.com
    Should Be True    ${result}
    ${record}=    Read Record By Id    users    99    user_id
    Log    Updated record: ${record}

TC-CRUD-008 Delete The Created User
    [Documentation]    Deletes the test user created in TC-CRUD-006.
    [Tags]             crud    delete
    ${result}=    Delete Record By Id    users    99    user_id
    Should Be True    ${result}
    ${count}=    Count Records In Table    users    user_id = 99
    Should Be Equal As Numbers    ${count}    0
    Log    User deleted successfully