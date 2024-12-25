import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/activity.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/accommodation.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/flight.dart';

final List<Itinerary> dummyItineraries = [
  Itinerary(
    title: 'Trip to Paris',
    startDate: DateTime(2023, 5, 1),
    endDate: DateTime(2023, 5, 10),
    destination: 'Paris, France',
    activities: [
      Activity(
        name: 'Eiffel Tower Visit',
        description: 'Visit the Eiffel Tower',
        date: DateTime(2023, 5, 2),
        time: DateTime(2023, 5, 2, 10, 0),
      ),
    ],
    accommodations: [
      Accommodation(
        name: 'Hotel Paris',
        checkInDate: DateTime(2023, 5, 1),
        checkOutDate: DateTime(2023, 5, 10),
        address: '123 Paris St, Paris, France',
      ),
    ],
    flights: [
      Flight(
        flightNumber: 'AF123',
        airline: 'Air France',
        departureTime: DateTime(2023, 5, 1, 8, 0),
        arrivalTime: DateTime(2023, 5, 1, 12, 0),
        departureAirport: 'JFK',
        arrivalAirport: 'CDG',
      ),
    ],
  ),
  Itinerary(
    title: 'Trip to Tokyo',
    startDate: DateTime(2023, 6, 15),
    endDate: DateTime(2023, 6, 25),
    destination: 'Tokyo, Japan',
    activities: [
      Activity(
        name: 'Tokyo Tower Visit',
        description: 'Visit the Tokyo Tower',
        date: DateTime(2023, 6, 16),
        time: DateTime(2023, 6, 16, 10, 0),
      ),
    ],
    accommodations: [
      Accommodation(
        name: 'Hotel Tokyo',
        checkInDate: DateTime(2023, 6, 15),
        checkOutDate: DateTime(2023, 6, 25),
        address: '456 Tokyo St, Tokyo, Japan',
      ),
    ],
    flights: [
      Flight(
        flightNumber: 'JL456',
        airline: 'Japan Airlines',
        departureTime: DateTime(2023, 6, 15, 8, 0),
        arrivalTime: DateTime(2023, 6, 15, 12, 0),
        departureAirport: 'LAX',
        arrivalAirport: 'NRT',
      ),
    ],
  ),
  Itinerary(
    title: 'Trip to Sydney',
    startDate: DateTime(2023, 7, 20),
    endDate: DateTime(2023, 7, 30),
    destination: 'Sydney, Australia',
    activities: [
      Activity(
        name: 'Sydney Opera House Visit',
        description: 'Visit the Sydney Opera House',
        date: DateTime(2023, 7, 21),
        time: DateTime(2023, 7, 21, 10, 0),
      ),
    ],
    accommodations: [
      Accommodation(
        name: 'Hotel Sydney',
        checkInDate: DateTime(2023, 7, 20),
        checkOutDate: DateTime(2023, 7, 30),
        address: '789 Sydney St, Sydney, Australia',
      ),
    ],
    flights: [
      Flight(
        flightNumber: 'QF789',
        airline: 'Qantas',
        departureTime: DateTime(2023, 7, 20, 8, 0),
        arrivalTime: DateTime(2023, 7, 20, 12, 0),
        departureAirport: 'SFO',
        arrivalAirport: 'SYD',
      ),
    ],
  ),
];
