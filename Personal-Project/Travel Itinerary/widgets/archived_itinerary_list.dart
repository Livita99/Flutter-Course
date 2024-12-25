import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/itinerary_card.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';
import 'package:flutter_workspace/Travel%20Itinerary/screens/history_screen.dart';

class ArchivedItineraryList extends StatelessWidget {
  final List<Itinerary> archivedItineraries;
  final Function(int) onUnarchive;

  const ArchivedItineraryList({
    super.key,
    required this.archivedItineraries,
    required this.onUnarchive,
  });

  @override
  Widget build(BuildContext context) {
    return archivedItineraries.isEmpty
        ? Center(
            child: Text(
              'No archived itineraries.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: archivedItineraries.length,
            itemBuilder: (context, index) {
              final itinerary = archivedItineraries[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(itinerary: itinerary),
                    ),
                  );
                },
                child: ItineraryCard(
                  title: itinerary.title,
                  startDate: itinerary.startDate,
                  endDate: itinerary.endDate,
                  onArchive: () => onUnarchive(index),
                ),
              );
            },
          );
  }
}
