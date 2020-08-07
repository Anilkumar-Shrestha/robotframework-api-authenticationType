*** Settings ***

Documentation    Test example for API key authentication requests.
Library    RequestsLibrary

*** Variables ***

${google_map_end_point}    https://maps.googleapis.com
${google_map_places_api_key}              AIzaSyCUEj_LqR74fK16C8bkK9mlY7QQ    # need to change here.

*** Test Cases ***

API Key Authentication Test
    [Documentation]    This is sample example of API key Authentication,
    ...     where we are using google map api keys for authentication

    set test variable   ${request_uri}    /maps/api/place/nearbysearch/json
    ${params}=    create dictionary    location=-33.8670522,151.1957362
    ...                                 radius=500
    ...                                 types=food
    ...                                 name=harbour
    ...                                 key=${google_map_places_api_key}
    create session    apikey_auth_session  ${google_map_end_point}   disable_warnings=1
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json

    ${response}=    get request    apikey_auth_session    ${request_uri}   headers=${headers}    params=${params}
#   Assertion test for checking status
    should be equal as strings    200  ${response.status_code}    msg=Response status code should be "200" but is ${response.status_code}.
    ${response_json}=    to json    ${response.content}
    log to console    **********************************
    log to console    ${response_json}
    log to console    **********************************
