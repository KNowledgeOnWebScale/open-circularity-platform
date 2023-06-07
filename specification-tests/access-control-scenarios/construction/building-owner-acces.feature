Feature: Building Owners' access


@bob-building-owner
Scenario: Building Owner can access product data from Lindner Group
    * def lindnerProductUrl = "https://css1/lindner-group/data/dt/out/products.ttl"
    Given url lindnerProductUrl
    And headers clients.bob.getAuthHeaders('GET', lindnerProductUrl)
    When method GET
    Then status 200
