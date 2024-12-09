*** Settings ***
Variables    variables.py
Library      DateTime
Library      Collections
Library      BuiltIn

*** Variables ***
${TIMECREATED}    2024-11-21 09:26:30 
*** Test Cases ***
Calculate Time Difference Between TimeCreated and Current Time
    Log To Console    TimeCreated (UTC): ${TIMECREATED}

    ${server_prefix}    Evaluate    "${server_name}"[:3]  
    Log To Console      Server Prefix: ${server_prefix}

    Set Suite Variable  ${mappings}  ${timezone_mappings}
    ${server_timezone_offset}    Get Timezone Offset From Variables    ${server_prefix}    ${mappings}
    Log To Console      Server Timezone Offset for ${server_name}: ${server_timezone_offset}

    ${time_difference}    Calculate Time Difference    ${TIMECREATED}    ${server_timezone_offset}
    Log To Console      The time difference between 'TimeCreated' (${TIMECREATED}) and the current time in the server timezone (offset: ${server_timezone_offset}) is: ${time_difference} seconds.

*** Keywords ***
Get Timezone Offset From Variables
    [Arguments]    ${server_prefix}    ${mappings}
    [Documentation]    Retrieve the timezone offset for the given server prefix from variables.
    ${offset}    Evaluate    ${mappings}.get("${server_prefix}", None)
    Run Keyword If    "${offset}" == "None"    Fail    Server prefix '${server_prefix}' not found in timezone mappings.
    Return From Keyword    ${offset}

Calculate Time Difference
    [Arguments]    ${time_created}    ${timezone_offset}
    # Step 1: Get current UTC time
    ${current_time_utc}    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log To Console    Current UTC Time: ${current_time_utc}

    # Step 2: Parse the timezone offset
    ${offset_hours}    Evaluate    int("${timezone_offset}".split(':')[0])
    ${offset_minutes}  Evaluate    int("${timezone_offset}".split(':')[1])

    # Step 3: Convert current time to the server timezone
    ${server_tz_current_time}    Evaluate    datetime.datetime.strptime("${current_time_utc}", '%Y-%m-%d %H:%M:%S') + datetime.timedelta(hours=${offset_hours}, minutes=${offset_minutes})
    Log To Console    Current Time in Server Timezone (Offset: ${timezone_offset}): ${server_tz_current_time}

    # Step 4: Calculate the absolute time difference in seconds
    ${time_difference}    Evaluate    abs((datetime.datetime.strptime("${server_tz_current_time}", '%Y-%m-%d %H:%M:%S') - datetime.datetime.strptime("${time_created}", '%Y-%m-%d %H:%M:%S')).total_seconds())
    Return From Keyword    ${time_difference}
