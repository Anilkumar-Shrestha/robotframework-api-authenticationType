*** Settings ***

Documentation    Test example for OAuth Bearer authentication requests.
Library    RequestsLibrary

*** Variables ***

${petfinder_end_point}    https://api.petfinder.com/v2
${client_id}              MHupDDv7gp3fJaN7ucmJxMJdBUr4moEeh1vDCRIG    # need to change this, check Readme how to get this
${client_secret}              pD0w1N8ckJmkP5ftRhkS0NqXNpXC398N    # need to change this, check Readme how to get this

*** Test Cases ***

Oauth Bearer Authentication Test
    [Documentation]    This is sample example of oauth bearer key Authentication,
    ...     where we are using petfinder api usinhg oauth for authentication

    ${access_token}=    get oauth access token for the petfinder api

# requesting dog type information from server using above access token
    ${params}=    create dictionary    type=dog    page=2
    &{headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ...               Authorization=Bearer ${access_token}
    ${response_dog_list}=    get request    bearer_auth_session    /animals    headers=${headers}    params=${params}

    should be equal as strings    200  ${response_dog_list.status_code}    msg=Response status code should be "200" but is ${response_dog_list.status_code}.
    ${response_dog_json}=    to json    ${response_dog_list.content}
    log to console    **********************************
    log to console    ${response_dog_json}
    log to console    **********************************



*** Keywords ***

GET OAUTH ACCESS TOKEN FOR THE PETFINDER API
    set test variable   ${request_uri}    /oauth2/token
    create session    bearer_auth_session  ${petfinder_end_point}   disable_warnings=1
    &{headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ${request_data}=        create dictionary    grant_type=client_credentials
    ...               client_id=${client_id}
    ...               client_secret=${client_secret}

#    getting bearer access tocken
    ${response}=    post request    bearer_auth_session    ${request_uri}  data=${request_data}   headers=${headers}
#   Assertion test for checking status
    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json['access_token']}
    log to console    **********************************

    [Return]    ${response_json['access_token']}
