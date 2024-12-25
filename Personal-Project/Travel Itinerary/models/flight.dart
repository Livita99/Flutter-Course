class Flight {
  Flight({
    required this.flightNumber,
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureAirport,
    required this.arrivalAirport,
  });

  final String flightNumber;
  final String airline;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String departureAirport;
  final String arrivalAirport;
}
