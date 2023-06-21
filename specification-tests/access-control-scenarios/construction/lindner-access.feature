Feature: Lindner-Group Access

  @alice-lindner
  Scenario: Lindner-Group can read Building-Owner 2 data
    * def buildingOwnerUrl = "https://css3/building-owner2/data/dt/out/buildings.ttl"
    Given url buildingOwnerUrl
    And headers clients.alice.getAuthHeaders('GET', buildingOwnerUrl)
    When method GET
    Then status 200

  @alice-lindner
  Scenario: Lindner-Group can read Building-Owner data
  * def buildingOwnerUrl = "https://css2/building-owner/data/dt/out/buildings.ttl"
  Given url buildingOwnerUrl
  And headers clients.alice.getAuthHeaders('GET', buildingOwnerUrl)
  When method Get 
  Then status 200
