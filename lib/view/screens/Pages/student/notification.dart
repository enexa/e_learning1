
 import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Schedule {
  final String description;
  final DateTime scheduledAt;

  Schedule({
    required this.description,
    required this.scheduledAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      description: json['description'],
      scheduledAt: DateTime.parse(json['scheduled_at']),
    );
  }
}

class ScheduleListScreen extends StatefulWidget {
  final String authToken;

  ScheduleListScreen({required this.authToken});

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late List<Schedule> schedules;

  @override
  void initState() {
    super.initState();
    schedules = []; // Initialize with an empty list
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    final url = Uri.parse('http://192.168.0.15:8000/api/schedules');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${widget.authToken}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final scheduleData = responseData['schedules'];

      List<Schedule> fetchedSchedules = [];
      for (var scheduleJson in scheduleData) {
        final schedule = Schedule.fromJson(scheduleJson);
        fetchedSchedules.add(schedule);
      }

      setState(() {
        schedules = fetchedSchedules;
      });
    } else {
      // Handle the error response
      print('Failed to fetch schedules: ${response.body}');
    }
  }

  Widget buildScheduleItem(Schedule schedule) {
    final now = DateTime.now();
    final scheduledTime = schedule.scheduledAt;
    final difference = scheduledTime.difference(now);

    return Card(
      child: ListTile(
        title: Text(schedule.description),
        subtitle: Text('Scheduled at: ${scheduledTime.toString()}'),
        trailing: Text('Countdown: ${difference.inMinutes} minutes'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule List'),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (BuildContext context, int index) {
          final schedule = schedules[index];
          return buildScheduleItem(schedule);
        },
      ),
    );
  }
}