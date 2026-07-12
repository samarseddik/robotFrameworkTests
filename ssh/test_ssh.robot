*** Settings ***
Documentation    Test cases for SSH keywords.
Resource         C:/Users/Lenovo/Desktop/robotFrameworkKeywords/keywords/ssh/SSHKeywords.robot
Library          OperatingSystem
Suite Setup      Connect To SSH Server    ${SSH_HOST}    ${SSH_USER}    password=${SSH_PASSWORD}
Suite Teardown   Disconnect All SSH Sessions

*** Variables ***
${SSH_HOST}        192.168.139.44
${SSH_USER}        lenovo
${SSH_PASSWORD}    samar21

*** Test Cases ***
TC-SSH-001 Verify SSH Connection
    [Documentation]    Verifies that SSH connection is established successfully.
    [Tags]             ssh    connection
    ${user}=    Get Current SSH User
    Should Not Be Empty    ${user}

TC-SSH-002 Get Current SSH User
    [Documentation]    Verifies that the current SSH user is returned correctly.
    [Tags]             ssh    connection
    ${user}=    Get Current SSH User
    Should Be Equal    ${user}    ${SSH_USER}

TC-SSH-003 Get Current SSH Directory
    [Documentation]    Verifies that the current working directory is returned.
    [Tags]             ssh    connection
    ${directory}=    Get Current SSH Directory
    Should Not Be Empty    ${directory}

TC-SSH-004 Execute SSH Command
    [Documentation]    Verifies that a simple command is executed and returns output.
    [Tags]             ssh    command
    ${output}=    Execute SSH Command    echo Hello Robot Framework
    Should Contain    ${output}    Hello Robot Framework

TC-SSH-005 Execute SSH Command With Details
    [Documentation]    Verifies that command returns stdout stderr and return code.
    [Tags]             ssh    command
    ${stdout}    ${stderr}    ${rc}=    Execute SSH Command With Details    echo test
    Should Be Equal As Integers    ${rc}    0
    Should Contain    ${stdout}    test

TC-SSH-006 Execute SSH Command And Verify Success
    [Documentation]    Verifies that a successful command has return code 0.
    [Tags]             ssh    command
    ${output}=    Execute SSH Command And Verify Success    ls /home
    Should Not Be Empty    ${output}

TC-SSH-007 Execute SSH Command And Verify Output
    [Documentation]    Verifies that command output contains expected text.
    [Tags]             ssh    command
    Execute SSH Command And Verify Output    echo RobotFramework    RobotFramework

TC-SSH-008 Execute SSH Command And Verify Error
    [Documentation]    Verifies that a failing command produces stderr output.
    [Tags]             ssh    command
    Execute SSH Command And Verify Error    ls /nonexistent_directory    No such file

TC-SSH-009 Upload File To SSH
    [Documentation]    Verifies that a file is uploaded to the remote server.
    [Tags]             ssh    transfer
    Create File    ${TEMPDIR}/test_upload.txt    Hello from Robot Framework
    Upload File To SSH    ${TEMPDIR}/test_upload.txt    /tmp/test_upload.txt
    ${exists}=    File Exists On SSH    /tmp/test_upload.txt
    Should Be True    ${exists}

TC-SSH-010 Download File From SSH
    [Documentation]    Verifies that a file is downloaded from the remote server.
    [Tags]             ssh    transfer
    Execute SSH Command    echo "Hello from remote" > /tmp/test_download_source.txt
    Download File From SSH    /tmp/test_download_source.txt    ${TEMPDIR}/test_download.txt
    OperatingSystem.File Should Exist    ${TEMPDIR}/test_download.txt

TC-SSH-011 File Exists On SSH
    [Documentation]    Verifies that an existing file is detected correctly.
    [Tags]             ssh    validation
    ${exists}=    File Exists On SSH    /etc/hostname
    Should Be True    ${exists}

TC-SSH-012 File Does Not Exist On SSH
    [Documentation]    Verifies that a non-existing file returns False.
    [Tags]             ssh    validation
    ${exists}=    File Exists On SSH    /tmp/nonexistent_file_xyz.txt
    Should Not Be True    ${exists}

TC-SSH-013 Directory Exists On SSH
    [Documentation]    Verifies that an existing directory is detected correctly.
    [Tags]             ssh    validation
    ${exists}=    Directory Exists On SSH    /home
    Should Be True    ${exists}

TC-SSH-014 Directory Does Not Exist On SSH
    [Documentation]    Verifies that a non-existing directory returns False.
    [Tags]             ssh    validation
    ${exists}=    Directory Exists On SSH    /nonexistent_directory_xyz
    Should Not Be True    ${exists}

TC-SSH-015 Switch SSH Session
    [Documentation]    Verifies that switching between sessions works correctly.
    [Tags]             ssh    connection
    Connect To SSH Server    ${SSH_HOST}    ${SSH_USER}    password=${SSH_PASSWORD}    alias=second
    Switch SSH Session    second
    ${user}=    Get Current SSH User    second
    Should Be Equal    ${user}    ${SSH_USER}
    Disconnect SSH Session    second