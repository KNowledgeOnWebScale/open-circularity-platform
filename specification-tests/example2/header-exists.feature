Feature: The WAC-Allow header is advertised

Scenario: Alice calls GET and gets the header
  Given url "https://localhost"
  When method GET
  Then status 200
  And match header Conent-Type != null
