Feature: Verify Branding Name

Scenario: Verify the authorization of branding endpoint

    * print baseUrl
    * print endpoint

    Given url baseUrl + endpoint.branding
    When method GET
    Then status 200

    * print responseStatus
    * print response

    # Verify name of the branding
    And match response.name == 'Shady Meadows B&B'

    # Verify contact details exist
    And match response.contact.email == '#present'
    And match response.contact.phone == '#present'
    And match response.description == '#present'

    # Verify email regex
    And match response.contact.email == '#regex ^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'