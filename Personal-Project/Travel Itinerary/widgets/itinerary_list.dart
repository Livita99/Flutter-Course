import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/itinerary_card.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';

class ItineraryList extends StatelessWidget {
  final List<Itinerary> itineraries;
  final Function(Itinerary, int) onEdit;
  final Function(int) onDelete;
  final Function(int) onArchive;

  const ItineraryList({
    super.key,
    required this.itineraries,
    required this.onEdit,
    required this.onDelete,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    return itineraries.isEmpty
        ? Center(
            child: Text(
              'No itineraries found. Click the + button to add a new itinerary.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: itineraries.length,
            itemBuilder: (context, index) {
              final itinerary = itineraries[index];
              return Dismissible(
                key: Key(itinerary.title),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  onDelete(index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: GestureDetector(
                  onDoubleTap: () => onEdit(itinerary, index),
                  child: ItineraryCard(
                    title: itinerary.title,
                    startDate: itinerary.startDate,
                    endDate: itinerary.endDate,
                    onArchive: () => onArchive(index),
                  ),
                ),
              );
            },
          );
  }
}
