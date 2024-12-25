import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/data/dummy_itineraries.dart';
import 'package:flutter_workspace/Travel%20Itinerary/data/dummy_packing_items.dart';
import 'package:flutter_workspace/Travel%20Itinerary/screens/checklist_screen.dart';
import 'package:flutter_workspace/Travel%20Itinerary/screens/profile_screen.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/new_itinerary_form.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/itinerary_list.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/archived_itinerary_list.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/packing_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Itinerary> _itineraries = [];
  final List<Itinerary> _archivedItineraries = [];
  final List<PackingItem> _packingItems = [];
  Itinerary? _recentlyDeletedItinerary;
  int? _recentlyDeletedItineraryIndex;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _itineraries.addAll(dummyItineraries);
    _packingItems.addAll(dummyPackingItems);
  }

  Future<void> _editItinerary(Itinerary itinerary, int index) async {
    final Itinerary? editedItinerary =
        await Navigator.of(context).push<Itinerary>(
      MaterialPageRoute(
        builder: (context) =>
            NewItineraryForm(itinerary: itinerary, mode: FormMode.edit),
      ),
    );

    if (editedItinerary != null) {
      setState(() {
        _itineraries[index] = editedItinerary;
      });
    }
  }

  void _deleteItinerary(int index) {
    setState(() {
      _recentlyDeletedItinerary = _itineraries[index];
      _recentlyDeletedItineraryIndex = index;
      _itineraries.removeAt(index);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Itinerary removed'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                if (_recentlyDeletedItinerary != null &&
                    _recentlyDeletedItineraryIndex != null) {
                  _itineraries.insert(_recentlyDeletedItineraryIndex!,
                      _recentlyDeletedItinerary!);
                }
              });
            },
          ),
        ),
      );
    });
  }

  void _archiveItinerary(int index) {
    setState(() {
      _archivedItineraries.add(_itineraries[index]);
      _itineraries.removeAt(index);
    });
  }

  void _unarchiveItinerary(int index) {
    setState(() {
      _itineraries.add(_archivedItineraries[index]);
      _archivedItineraries.removeAt(index);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddItemDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Item Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    _packingItems.add(PackingItem(
                        name: nameController.text, isPacked: false));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ItineraryList(
        itineraries: _itineraries,
        onEdit: _editItinerary,
        onDelete: _deleteItinerary,
        onArchive: _archiveItinerary,
      ),
      ChecklistScreen(packingItems: _packingItems),
      ArchivedItineraryList(
        archivedItineraries: _archivedItineraries,
        onUnarchive: _unarchiveItinerary,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'My Travel Itineraries'
            : _selectedIndex == 1
                ? 'Checklist'
                : _selectedIndex == 2
                    ? 'Archived Itineraries'
                    : 'Profile'),
        actions: _selectedIndex == 0
            ? [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final Itinerary? newItinerary =
                        await Navigator.of(context).push<Itinerary>(
                      MaterialPageRoute(
                        builder: (context) =>
                            NewItineraryForm(mode: FormMode.create),
                      ),
                    );

                    if (newItinerary != null) {
                      setState(() {
                        _itineraries.add(newItinerary);
                      });
                    }
                  },
                ),
              ]
            : _selectedIndex == 1
                ? [
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _showAddItemDialog,
                    ),
                  ]
                : null,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Checklist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
