*** Settings ***
Documentation    Test cases for test data management keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseConnection.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseCRUD.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseValidation.robot
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/database/DatabaseSetup.robot
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
TC-DM-001 Setup Test Table
    [Documentation]    Creates a test table using a generic SQL schema.
    [Tags]             data-management    setup
    ${sql}=    Set Variable    CREATE TABLE IF NOT EXISTS test_table (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, value VARCHAR(255), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
    ${result}=    Setup Test Table    ${sql}
    Should Be True    ${result}

TC-DM-002 Insert Single Test Record
    [Documentation]    Inserts a single record into the test table.
    [Tags]             data-management    insert
    ${result}=    Create Record In Table    test_table
    ...    name=Record1
    ...    value=Value1
    Should Be True    ${result}

TC-DM-003 Insert Multiple Test Records
    [Documentation]    Inserts multiple records into the test table.
    [Tags]             data-management    insert
    ${record1}=    Create Dictionary    name=Record2    value=Value2
    ${record2}=    Create Dictionary    name=Record3    value=Value3
    ${records}=    Create List    ${record1}    ${record2}
    FOR    ${record}    IN    @{records}
        Create Record In Table    test_table    &{record}
    END

TC-DM-004 Verify Test Records Exist
    [Documentation]    Verifies the inserted records exist in the test table.
    [Tags]             data-management    validation
    ${result}=    Verify Record Exists    test_table    name = 'Record1'
    Should Be True    ${result}
    ${result}=    Verify Record Exists    test_table    name = 'Record2'
    Should Be True    ${result}
    ${result}=    Verify Record Exists    test_table    name = 'Record3'
    Should Be True    ${result}

TC-DM-005 Cleanup Single Test Record
    [Documentation]    Deletes a specific record from the test table.
    [Tags]             data-management    cleanup
    ${result}=    Cleanup Test Record    test_table    name = 'Record1'
    Should Be True    ${result}
    ${result}=    Verify Record Does Not Exist    test_table    name = 'Record1'
    Should Be True    ${result}

TC-DM-006 Cleanup Test Table
    [Documentation]    Truncates the test table.
    [Tags]             data-management    cleanup
    ${result}=    Cleanup Test Table    test_table
    Should Be True    ${result}

TC-DM-007 Drop Test Table
    [Documentation]    Drops the test table completely.
    [Tags]             data-management    cleanup
    ${result}=    Drop Test Table    test_table
    Should Be True    ${result}
    Log    Table test_table dropped successfully