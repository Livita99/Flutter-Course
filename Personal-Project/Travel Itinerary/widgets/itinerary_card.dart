import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryCard extends StatelessWidget {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback onArchive;
  final VoidCallback? onUnarchive;

  const ItineraryCard({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.onArchive,
    this.onUnarchive,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'archive') {
                            onArchive();
                          } else if (value == 'unarchive' &&
                              onUnarchive != null) {
                            onUnarchive!();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value:
                                  onUnarchive != null ? 'unarchive' : 'archive',
                              child: Text(onUnarchive != null
                                  ? 'Unarchive'
                                  : 'Archive'),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.date_range, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
