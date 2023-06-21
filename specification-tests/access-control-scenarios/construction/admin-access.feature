Feature: "Admin Access"

@alice-admin
Scenario: "Admin can read lindner-group generated data (products)"
    * def targetUrl = "https://css1/lindner-group/data/dt/out/products.ttl"
    Given url targetUrl
    And headers clients.alice.getAuthHeaders('GET', targetUrl)
    When method GET 
    Then status 200

@alice-admin
Scenario: "Admin can read lindner-group generated data (materials)"
    * def targetUrl = "https://css1/lindner-group/data/dt/out/materials.ttl"
    Given url targetUrl
    And headers clients.alice.getAuthHeaders('GET', targetUrl)
    When method GET 
    Then status 200

@alice-admin
Scenario: "Admin can read lindner-group generated data (boms)"
    * def targetUrl = "https://css1/lindner-group/data/dt/out/boms.ttl"
    Given url targetUrl
    And headers clients.alice.getAuthHeaders('GET', targetUrl)
    When method GET 
    Then status 200

@alice-admin
Scenario: "Admin can read building-owner generated data (buildings)"
    * def targetUrl = "https://css2/building-owner/data/dt/out/buildings.ttl"
    Given url targetUrl
    And headers clients.alice.getAuthHeaders('GET', targetUrl)
    When method GET 
    Then status 200
