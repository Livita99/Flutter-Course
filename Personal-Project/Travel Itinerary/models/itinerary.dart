import 'package:flutter_workspace/Travel%20Itinerary/models/flight.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/activity.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/accommodation.dart';

class Itinerary {
  Itinerary({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.destination,
    required this.activities,
    required this.accommodations,
    required this.flights,
  });

  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String destination;

  final List<Activity> activities;
  final List<Accommodation> accommodations;
  final List<Flight> flights;
}
