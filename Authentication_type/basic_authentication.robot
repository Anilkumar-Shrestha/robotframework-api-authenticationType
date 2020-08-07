*** Settings ***

Documentation    Test example for Basic authentication requests.
Library    RequestsLibrary

*** Variables ***

${regres_end_point}    https://reqres.in
${github_end_point}    https://api.github.com
${github_username}     nl.shrestha90@gmail.com     # need to change this
${github_password}     password     # need to change this
${base64_encoded_token}    bmwuc2hyZXN0aGE5MEBnbWFpbC5jb206cGFzc3dvcmQ=     # need to change this, Check Readme how to get this.

*** Test Cases ***

Basic Authentication to login using username and Password with Post Requests.
    [Documentation]    This is sample example of Basic Authentication, where we are sending Post request with Username and Password.
    ${basic_auth}=    create dictionary    username=eve.holt@reqres.in    password=cityslicka
    create session    basic_auth_session  ${regres_end_point}   disable_warnings=1
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json

    ${response}=    post request    basic_auth_session  /api/login    data=${basic_auth}    headers=${headers}
#   Assertion test for checking status
    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json}
    log to console    **********************************


Basic Authentication to login Github using username and Password with Get Request.
    [Documentation]    This is sample example of Basic Authentication, where we are sending Get request with Username and Password.
    ${basic_auth}=    create list    ${github_username}    ${github_password}
    create session    github_session  ${github_end_point}  auth=${basic_auth}   disable_warnings=1    verify=${true}
    ${headers}=    create dictionary    Content-Type=application/json
    ${response}=    get request   github_session   /user/repos   headers=${headers}

#   Assertion test for checking status
    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json}
    log to console    **********************************

Basic Authentication to login Github using Basic Authorization token
    [Documentation]    This is above same example of Basic Authentication, where we are sending Get request with Authorization token.
    create session    github_session  ${github_end_point}  disable_warnings=1    verify=${true}
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ...               Authorization=Basic ${base64_encoded_token}
    ${response}=    get request   github_session   /user/repos   headers=${headers}

    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json}
    log to console    **********************************
