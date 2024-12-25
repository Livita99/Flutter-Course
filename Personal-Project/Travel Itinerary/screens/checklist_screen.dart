import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/packing_item.dart';

class ChecklistScreen extends StatefulWidget {
  final List<PackingItem> packingItems;

  const ChecklistScreen({super.key, required this.packingItems});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  PackingItem? _recentlyDeletedItem;
  int? _recentlyDeletedItemIndex;

  void _togglePacked(int index) {
    setState(() {
      widget.packingItems[index] = PackingItem(
        name: widget.packingItems[index].name,
        isPacked: !widget.packingItems[index].isPacked,
      );
    });
  }

  void _editItem(int index) {
    final TextEditingController nameController = TextEditingController();
    nameController.text = widget.packingItems[index].name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
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
                    widget.packingItems[index] = PackingItem(
                      name: nameController.text,
                      isPacked: widget.packingItems[index].isPacked,
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void showAddItemDialog() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Item'),
              content: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: nameController.text.isNotEmpty
                      ? () {
                          setState(() {
                            widget.packingItems.add(PackingItem(
                                name: nameController.text, isPacked: false));
                          });
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Text(
                    'Add',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _recentlyDeletedItem = widget.packingItems[index];
      _recentlyDeletedItemIndex = index;
      widget.packingItems.removeAt(index);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item removed'),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                if (_recentlyDeletedItem != null &&
                    _recentlyDeletedItemIndex != null) {
                  widget.packingItems.insert(
                      _recentlyDeletedItemIndex!, _recentlyDeletedItem!);
                }
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.packingItems.isEmpty
        ? Center(
            child: Text(
              'No items in the checklist. Click the + button to add a new item.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: widget.packingItems.length,
            itemBuilder: (context, index) {
              final item = widget.packingItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _togglePacked(index);
                        },
                        child: Checkbox(
                          value: item.isPacked,
                          onChanged: (bool? value) {
                            _togglePacked(index);
                          },
                        ),
                      ),
                      Expanded(child: Text(item.name)),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editItem(index);
                      } else if (value == 'delete') {
                        _deleteItem(index);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          );
  }
}
