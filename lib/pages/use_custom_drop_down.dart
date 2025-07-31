import 'package:flutter/material.dart';

import '../widgets/custom_dropdown.dart';

class TestUseCustomDropDown extends StatefulWidget {
  const TestUseCustomDropDown({super.key});

  @override
  State<TestUseCustomDropDown> createState() => _TestUseCustomDropDownState();
}

class _TestUseCustomDropDownState extends State<TestUseCustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Custom Dropdown Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Dropdown Widget Test',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'This is a test page for the reusable CustomDropdown widget.\n'
                'Select an option below and observe the output in the debug console.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // My Custom Dropdown Widget
              CustomDropdown(
                width: 250,
                options: [
                  'One',
                  'Two',
                  'Three',
                  'Four',
                  // 'Five',
                  // 'Six',
                  // 'Seven',
                  // 'Eight',
                  // 'Nine',
                  // 'Ten',
                  // 'Eleven',
                  // 'Twelve',
                ],
                initialValue: 'One',
                onChanged: (val) => debugPrint('Selected: $val'),
              ),

              const Text(
                'You can add more widgets here to test different UI layouts.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
