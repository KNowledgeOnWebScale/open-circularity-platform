Feature: RDF library support 

    Background: Create a ttl 
        * def turtleData = { foo: 'bar' }

    Scenario: Model contains passes
        * match turtleData != { foo: 'baz' } 