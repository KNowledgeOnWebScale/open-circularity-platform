Feature: Building Owners' access


@bob-building-owner
Scenario: Building Owner can access product data from Lindner Group
    * def targetUrl = "https://css1/lindner-group/data/dt/out/products.ttl"
    Given url targetUrl
    And headers clients.bob.getAuthHeaders('GET', targetUrl)
    When method GET
    Then status 200

@bob-building-owner
Scenario: Building Owner can NOT access Bill of Materials (BOM) data from Lindner Group
    * def targetUrl = "https://css1/lindner-group/data/dt/out/boms.ttl"
    Given url targetUrl
    And headers clients.bob.getAuthHeaders('GET', targetUrl)
    When method GET
    Then status 403


@bob-building-owner
Scenario: Building Owner can NOT access Materials data from Lindner Group
    * def targetUrl = "https://css1/lindner-group/data/dt/out/materials.ttl"
    Given url targetUrl
    And headers clients.bob.getAuthHeaders('GET', targetUrl)
    When method GET
    Then status 403
