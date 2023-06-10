
 import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime selectedDateTime;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    selectedDateTime = DateTime.now();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> createSchedule() async {
    final url = Uri.parse('http://192.168.0.15:8000/api/schedules');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer YOUR_AUTH_TOKEN',
      },
      body: jsonEncode({
        'description': descriptionController.text,
        'scheduled_at': selectedDateTime.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final message = responseData['message'];
      final schedule = responseData['schedule'];

      // Handle the response as needed
      print('Schedule created successfully: $message');
      print('Schedule details: $schedule');
    } else {
      // Handle the error response
      print('Failed to create schedule: ${response.body}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  // Rest of the code...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Date & Time:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              selectedDateTime.toString(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter schedule description',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: createSchedule,
              child: const Text('Create Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}
