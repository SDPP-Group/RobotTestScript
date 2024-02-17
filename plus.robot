*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary

*** Keywords ***
To Plus
    [Arguments]    ${a}    ${b}
    ${response}=        Get        http://localhost:9080/plus/${a}/${b}    expected_status=any
    RETURN        ${response}

*** Test Cases ***
Test Plus Two Integers
    ${response}=    To Plus    1    2
    Status Should Be  200
    ${result}=        Set Variable        ${response.json()['result']}
    Should Be Equal As Integers    ${result}    3

Test Plus Two Floats
    ${response}=    To Plus    1.1    2.2
    Status Should Be  400
    ${result}=        Set Variable        ${response.json()['message']}
    Should Be Equal As Strings    ${result}    Invalid input

Test Plus One Floats One Integers
    ${response}=    To Plus    1.1    2
    Status Should Be  400
    ${result}=        Set Variable        ${response.json()['message']}
    Should Be Equal As Strings    ${result}    Invalid input
Test Plus Two Strings
    ${response}=    To Plus    a    a
    Status Should Be    400
    ${result}=    Set Variable    ${response.json()['message']}
    Should Be Equal As Strings    ${result}    Invalid input

Test Plus One Strings One Integer
    ${response}=    To Plus    a    1
    Status Should Be    400
    ${result}=    Set Variable    ${response.json()['message']}
    Should Be Equal As Strings    ${result}    Invalid input

Test Plus One Strings One Float
    ${response}=    To Plus    a    1.1
    Status Should Be    400
    ${result}=    Set Variable    ${response.json()['message']}
    Should Be Equal As Strings    ${result}    Invalid input