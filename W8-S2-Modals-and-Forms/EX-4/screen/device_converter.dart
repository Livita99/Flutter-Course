import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Device { euro, riels, dong }

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final List<Device> _dropdownItems = Device.values;
  final TextEditingController _amountController = TextEditingController();

  Device? _selectedDevice;
  double? _convertedAmount;

  final Map<Device, double> _conversionRates = {
    Device.euro: 0.95,
    Device.riels: 4000,
    Device.dong: 25346.49,
  };

  void onChanged(Device? newValue) {
    setState(() {
      _selectedDevice = newValue!;
      _convertAmount();
    });
  }

  void _convertAmount() {
    if (_amountController.text.isEmpty) {
      setState(() {
        _convertedAmount = 0.00;
      });
      return;
    }

    if (_selectedDevice != null && _amountController.text.isNotEmpty) {
      double amountInDollars = double.parse(_amountController.text);
      double conversionRate = _conversionRates[_selectedDevice]!;
      setState(() {
        _convertedAmount = amountInDollars * conversionRate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollar',
                hintStyle: const TextStyle(color: Colors.white)),
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            onChanged: (value) => _convertAmount(),
          ),
          const SizedBox(height: 30),
          const Text("Device:"),
          DropdownButton(
            value: _selectedDevice,
            onChanged: onChanged,
            items: _dropdownItems.map((Device device) {
              return DropdownMenuItem(
                value: device,
                child: Text(device.toString().split('.').last.toUpperCase()),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                _convertedAmount != null
                    ? _convertedAmount!.toStringAsFixed(2)
                    : '0.00',
                style: const TextStyle(color: Colors.black),
              )),
        ],
      )),
    );
  }
}
