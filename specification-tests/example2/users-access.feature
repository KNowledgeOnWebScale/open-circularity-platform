Feature: "Access for all users"

Scenario: "Can get Ragn-Selss' service descriptions. (no auth)"
    * def descriptionsUrl = "https://css4/ragn-sells/data/dt/out/services.ttl"
    Given url descriptionsUrl
    When method GET 
    Then status 200
