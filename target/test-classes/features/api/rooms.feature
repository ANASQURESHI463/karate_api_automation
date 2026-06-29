Feature: Check Available Rooms & book the valid room

  Background:
    * url baseUrl
    * def endpoints = endpoint

    # ---- LOGIN (runs before every scenario) ----
    * def loginRequest =
    """
    {
      "username": "admin",
      "password": "password"
    }
    """

    Given path endpoints.auth
    And request loginRequest
    When method POST
    Then status 200

    * def authToken = response.token
    * def authHeader = 'Bearer ' + authToken


  Scenario: Verify available rooms

    Given path endpoints.rooms
    When method GET
    Then status 200

    * print response

    # rooms array validation
    And match response.rooms == '#[]'
    And assert response.rooms.length > 0

    # filter valid rooms
    * def validRooms = karate.filter(response.rooms, function(x){ return x.roomPrice > 0 })
    And assert validRooms.length > 0

    # pick room
    * def roomId = response.rooms[1].roomid
    * print 'Room ID:', roomId
    


  Scenario: Create a booking for valid room

    Given path endpoints.rooms
    When method GET
    Then status 200
    * def validRooms = karate.filter(response.rooms, function(x){ return x.roomPrice > 0 })
    * def roomId = response.rooms[0].roomid
    * def today = java.time.LocalDate.now().plusDays(1).toString()
    * def checkout = java.time.LocalDate.now().plusDays(3).toString()
    * def bookingRequest =
    """
          {
        "roomid": "#(roomId)",
        "firstname": "Anas",
        "lastname": "Qureshi",
        "depositpaid": true,
        "bookingdates": {
          "checkin": "#(today)",
          "checkout": "#(checkout)"
        }
    }
    """

    Given path endpoints.booking
    And header Authorization = authHeader
    And request bookingRequest
    When method POST
    Then status 201

    * print response

    And match response.bookingid == '#number'
    And match response.firstname == 'Anas'
    And match response.lastname == 'Qureshi'
