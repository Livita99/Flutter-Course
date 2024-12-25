import 'package:flutter/material.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/itinerary.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/flight.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/activity.dart';
import 'package:flutter_workspace/Travel%20Itinerary/models/accommodation.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/accommodation_form.dart';
import 'package:flutter_workspace/Travel%20Itinerary/widgets/activity_form.dart';
import 'package:intl/intl.dart';

enum FormMode { create, edit }

class NewItineraryForm extends StatefulWidget {
  final Itinerary? itinerary;
  final FormMode mode;

  const NewItineraryForm({super.key, this.itinerary, required this.mode});

  @override
  State<NewItineraryForm> createState() {
    return _NewItineraryFormState();
  }
}

class _NewItineraryFormState extends State<NewItineraryForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _destinationController = TextEditingController();
  final _flightNumberController = TextEditingController();
  final _airlineController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _departureAirportController = TextEditingController();
  final _arrivalAirportController = TextEditingController();
  final List<Activity> _activities = [];
  final List<Accommodation> _accommodations = [];
  DateTimeRange? selectedDateRange;
  TimeOfDay? selectedDepartureTime;
  TimeOfDay? selectedArrivalTime;

  @override
  void initState() {
    super.initState();
    if (widget.mode == FormMode.edit && widget.itinerary != null) {
      _titleController.text = widget.itinerary!.title;
      _destinationController.text = widget.itinerary!.destination;
      selectedDateRange = DateTimeRange(
        start: widget.itinerary!.startDate,
        end: widget.itinerary!.endDate,
      );
      if (widget.itinerary!.flights.isNotEmpty) {
        final flight = widget.itinerary!.flights.first;
        _flightNumberController.text = flight.flightNumber;
        _airlineController.text = flight.airline;
        selectedDepartureTime = TimeOfDay.fromDateTime(flight.departureTime);
        selectedArrivalTime = TimeOfDay.fromDateTime(flight.arrivalTime);
        _departureAirportController.text = flight.departureAirport;
        _arrivalAirportController.text = flight.arrivalAirport;
      }
      _activities.addAll(widget.itinerary!.activities);
      _accommodations.addAll(widget.itinerary!.accommodations);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _flightNumberController.dispose();
    _airlineController.dispose();
    _departureTimeController.dispose();
    _arrivalTimeController.dispose();
    _departureAirportController.dispose();
    _arrivalAirportController.dispose();
    super.dispose();
  }

  Future<void> _pickDateRange() async {
    DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: selectedDateRange,
      helpText: 'Select your travel dates',
      saveText: 'Save',
    );

    if (pickedDateRange != null) {
      setState(() {
        selectedDateRange = pickedDateRange;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          selectedDepartureTime = picked;
        } else {
          selectedArrivalTime = picked;
        }
      });
    }
  }

  void _saveItinerary() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      final newItinerary = Itinerary(
        title: _titleController.text,
        startDate: selectedDateRange!.start,
        endDate: selectedDateRange!.end,
        destination: _destinationController.text,
        activities: _activities,
        accommodations: _accommodations,
        flights: [
          Flight(
            flightNumber: _flightNumberController.text,
            airline: _airlineController.text,
            departureTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              selectedDepartureTime!.hour,
              selectedDepartureTime!.minute,
            ),
            arrivalTime: DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              selectedArrivalTime!.hour,
              selectedArrivalTime!.minute,
            ),
            departureAirport: _departureAirportController.text,
            arrivalAirport: _arrivalAirportController.text,
          ),
        ],
      );
      print('New Itinerary Created: ${newItinerary.title}');
      Navigator.pop(context, newItinerary);
    } else {
      print('Form is not valid');
    }
  }

  void _addActivity(Activity activity) {
    setState(() {
      _activities.add(activity);
    });
  }

  void _showAddActivityDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ActivityForm(onAddActivity: _addActivity);
      },
    );
  }

  Future<void> _showAddAccommodationDialog() async {
    final Accommodation? newAccommodation = await showDialog<Accommodation>(
      context: context,
      builder: (context) {
        return AccommodationForm();
      },
    );

    if (newAccommodation != null) {
      setState(() {
        _accommodations.add(newAccommodation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == FormMode.create
            ? 'New Itinerary'
            : 'Edit Itinerary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _destinationController,
                        decoration: InputDecoration(labelText: 'Destination'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a destination';
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        alignment: Alignment.centerRight,
                        child: Text(
                          selectedDateRange == null
                              ? 'Select Date Range'
                              : '${DateFormat('dd/MM/yyyy').format(selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(selectedDateRange!.end)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedDateRange == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: _pickDateRange,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Flight Details',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _flightNumberController,
                  decoration: InputDecoration(labelText: 'Flight Number'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a flight number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _airlineController,
                  decoration: InputDecoration(labelText: 'Airline'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an airline';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectedDepartureTime == null
                              ? 'Select Departure Time'
                              : selectedDepartureTime!.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedDepartureTime == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.flight_takeoff),
                      onPressed: () => _selectTime(context, true),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectedArrivalTime == null
                              ? 'Select Arrival Time'
                              : selectedArrivalTime!.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedArrivalTime == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.flight_land),
                      onPressed: () => _selectTime(context, false),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _departureAirportController,
                  decoration: InputDecoration(labelText: 'Departure Airport'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a departure airport';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _arrivalAirportController,
                  decoration: InputDecoration(labelText: 'Arrival Airport'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an arrival airport';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Activities',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _showAddActivityDialog,
                      ),
                    ],
                  ),
                ),
                ..._activities.map((activity) {
                  return ListTile(
                    title: Text(activity.name),
                    subtitle: Text(
                      '(${activity.description}) - ${DateFormat('dd/MM/yyyy').format(activity.date)} - ${DateFormat('hh:mm a').format(activity.time)}',
                    ),
                  );
                }),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Accommodations',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _showAddAccommodationDialog,
                      ),
                    ],
                  ),
                ),
                ..._accommodations.map((accommodation) {
                  return ListTile(
                    title: Text(accommodation.name),
                    subtitle: Text(
                      '${accommodation.address} - ${DateFormat('dd/MM/yyyy').format(accommodation.checkInDate)} to ${DateFormat('dd/MM/yyyy').format(accommodation.checkOutDate)}',
                    ),
                  );
                }),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _saveItinerary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[100],
                    ),
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
