import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../models/user.dart';
import '../../colors.dart';
import 'dart:convert';

import 'myonline.dart';


import 'package:e_learning/models/api_response.dart';

import 'package:e_learning/controller/service/use_service.dart';

import '../../widget/constants.dart';
import 'package:uuid/uuid.dart';
import 'login.dart';
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
  const ScheduleListScreen({Key? key}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late List<Schedule> schedules;
  Timer? timer;
  User? user;

  @override
  void initState() {
    super.initState();
 
    schedules = []; // Initialize with an empty list
    fetchSchedules();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

 


  Future<void> fetchSchedules() async {
    final url = Uri.parse('http://192.168.0.15:8000/api/schedules');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1|W8DIFtBJYZP9kFKcNbnLhEhrHiYSESxtsX5IFodx',
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

      startCountdownTimers(); // Start countdown timers after fetching schedules
    } else {
      // Handle the error response
      print('Failed to fetch schedules: ${response.body}');
    }
  }

  void startCountdownTimers() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      // Update countdown timers every second
      setState(() {});
    });
  }

  String formatCountdown(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }

  Widget buildScheduleItem(Schedule schedule) {
    final now = DateTime.now();
    final scheduledTime = schedule.scheduledAt;
    final difference = scheduledTime.difference(now);

    if (difference.isNegative) {
     
      return Card(
        child: ListTile(
          title: Text(schedule.description),
          subtitle: Text('Scheduled at: ${scheduledTime.toString()}'),
          trailing: ElevatedButton(
            onPressed: () {
         
  Get.to(const LiveStream());
            },
            child: Text('Join Live'),
          ),
        ),
      );
    } else {
      // Countdown is still ongoing, show the ticking countdown
      final countdown = formatCountdown(difference);

      return Card(
        child: ListTile(
          title: Text(schedule.description),
          subtitle: Text('Scheduled at: ${scheduledTime.toString()}'),
          trailing: Text('Countdown: $countdown'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new,
              color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        title: Text('Schedule List',
            style: headingstyle(Get.isDarkMode ? Colors.white : Colors.black)),
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
