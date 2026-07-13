*** Settings ***
Documentation    Test cases for ApiConfig keywords.
Resource    ${KEYWORDS_PATH}/api/ApiConfig.robot
Suite Teardown   Reset API Configuration

*** Test Cases ***
TC-CFG-001 Configure Default Headers
    [Documentation]    Verifies that default headers can be configured.
    [Tags]             api    config
    ${headers}=    Configure Default Headers
    Should Not Be Empty    ${headers}
    Dictionary Should Contain Key    ${headers}    Content-Type
    Dictionary Should Contain Key    ${headers}    Accept

TC-CFG-002 Get Default Headers
    [Documentation]    Verifies that default headers are returned correctly.
    [Tags]             api    config
    Configure Default Headers
    ${headers}=    Get Default Headers
    Should Not Be Empty    ${headers}

TC-CFG-003 Configure Default Headers With Custom Content Type
    [Documentation]    Verifies that custom content type can be set.
    [Tags]             api    config
    ${headers}=    Configure Default Headers    content_type=application/xml
    Should Be Equal    ${headers}[Content-Type]    application/xml

TC-CFG-004 Configure Timeout
    [Documentation]    Verifies that timeout can be configured.
    [Tags]             api    config
    ${timeout}=    Configure Timeout    60
    Should Be Equal As Integers    ${timeout}    60

TC-CFG-005 Configure SSL Verification
    [Documentation]    Verifies that SSL verification can be configured.
    [Tags]             api    config
    ${verify}=    Configure SSL Verification    ${False}
    Should Be Equal    ${verify}    ${False}
    Configure SSL Verification    ${True}

TC-CFG-006 Configure Proxy
    [Documentation]    Verifies that proxy settings can be configured.
    [Tags]             api    config
    ${result}=    Configure Proxy    http_proxy=http://proxy:8080
    Should Be True    ${result}

TC-CFG-007 Get Proxy Configuration
    [Documentation]    Verifies that proxy configuration is returned correctly.
    [Tags]             api    config
    Configure Proxy    http_proxy=http://proxy:8080    https_proxy=https://proxy:8443
    ${proxy}=    Get Proxy Configuration
    Should Not Be Empty    ${proxy}
    Dictionary Should Contain Key    ${proxy}    http
    Dictionary Should Contain Key    ${proxy}    https

TC-CFG-008 Reset API Configuration
    [Documentation]    Verifies that API configuration can be reset to defaults.
    [Tags]             api    config
    Configure Timeout    60
    Configure SSL Verification    ${False}
    ${result}=    Reset API Configuration
    Should Be True    ${result}