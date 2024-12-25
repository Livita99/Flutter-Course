import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';

class HistoryScreen extends StatelessWidget {
  final Itinerary itinerary;

  const HistoryScreen({super.key, required this.itinerary});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text(itinerary.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Destination: ${itinerary.destination}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Start Date: ${dateFormat.format(itinerary.startDate)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'End Date: ${dateFormat.format(itinerary.endDate)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Activities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...itinerary.activities.map((activity) {
              return ListTile(
                title: Text(activity.name),
                subtitle: Text(
                  '${activity.description}\nDate: ${dateFormat.format(activity.date)}\nTime: ${DateFormat('hh:mm a').format(activity.time)}',
                ),
              );
            }),
            SizedBox(height: 16),
            Text(
              'Accommodations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...itinerary.accommodations.map((accommodation) {
              return ListTile(
                title: Text(accommodation.name),
                subtitle: Text(
                  '${accommodation.address}\nCheck-in: ${dateFormat.format(accommodation.checkInDate)}\nCheck-out: ${dateFormat.format(accommodation.checkOutDate)}',
                ),
              );
            }),
            SizedBox(height: 16),
            Text(
              'Flights:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...itinerary.flights.map((flight) {
              return ListTile(
                title: Text(flight.flightNumber),
                subtitle: Text(
                  '${flight.departureAirport} to ${flight.arrivalAirport}\nDeparture: ${dateFormat.format(flight.departureTime)}\nArrival: ${dateFormat.format(flight.arrivalTime)}',
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
