*** Settings ***
Documentation    This test suites is example of how to request grpahql query
Library    RequestsLibrary


*** Variables ***
${graphql_github_endpoint}   https://api.github.com
${graphql_swapi_endpoint}   https://api.graph.cool/simple/v1/swapi
${access_token}    9269e9c5c266b4ea27b3598cc645fa67    # need to change here with your acces token


*** Test Cases ***
graphql github query request with access token

    create session    graphql_github_session  ${graphql_github_endpoint}   disable_warnings=1
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ...               Authorization=Bearer ${access_token}
    ${data}=   create dictionary    query=query{ viewer { login }}

    ${response}=    post request    graphql_github_session   /graphql    data=${data}    headers=${headers}
    request should be successful    ${response}
    log to console    ${response.content}


graphql github query request passing variable inside query

    create session    graphql_github_session  ${graphql_github_endpoint}   disable_warnings=1
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ...               Authorization=Bearer ${access_token}
    set test variable    ${number_of_repos}    2
    ${data}=   create dictionary    query=query{viewer{name repositories(last: ${number_of_repos}) {nodes {name}}}}

    ${response}=    post request    graphql_github_session   /graphql    data=${data}    headers=${headers}
    request should be successful    ${response}
    log to console    ${response.content}


graphql api query with no Access token

    create session    graphql_swapi_session  ${graphql_swapi_endpoint}   disable_warnings=1
    ${headers}=    create dictionary    Content-Type=application/json
    ...               Accept=application/json
    ${data}=    create dictionary    query={allPersons{name films { director } } }
    ${response}=    post request    graphql_swapi_session  /   data=${data}    headers=${headers}
    request should be successful    ${response}
#    log to console    ${response.content}