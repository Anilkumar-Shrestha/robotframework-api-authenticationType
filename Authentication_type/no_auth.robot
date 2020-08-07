*** Settings ***
Documentation    Test example for No authentication requests.
Library    RequestsLibrary

*** Variables ***
${end_point}    https://api.publicapis.org

*** Test Cases ***

No Authentication example to get Random list of open Public APIs

    create session    no_auth_session  ${end_point}  disable_warnings=1
    ${params}=    create dictionary    auth=null
    ${response}=    get request  no_auth_session  /random   params=${params}
#    Assertions
    log to console    ${response.status_code}
    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json}
    log to console    **********************************
