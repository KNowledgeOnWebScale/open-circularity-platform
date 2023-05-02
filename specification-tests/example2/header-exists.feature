Feature: Headers

    Scenario: Can get Lindner-Group webId
    Given url "https://css1/lindner-group/profile/card#me"
    When method GET
    Then status 200
    And match header Content-Type == "text/turtle"

    Scenario: Can get Admin webId
    Given url "https://css0/admin/profile/card#me"
    When method GET
    Then status 200
    And match header Content-Type == "text/turtle"

    Scenario: Can get Building-Owner 2 webId
    Given url "https://css3/building-owner2/profile/card#me"
    When method GET
    Then status 200
    And match header Content-Type == "text/turtle"

    Scenario: Can get Building-Owner webId
    Given url "https://css2/building-owner/profile/card#me"
    When method GET
    Then status 200
    And match header Content-Type == "text/turtle"
