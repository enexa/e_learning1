
// ignore_for_file: avoid_print, duplicate_ignore, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, depend_on_referenced_packages


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';



import 'package:timezone/data/latest.dart'as tz;

import'package:timezone/timezone.dart' as tz;

import '../../../models/schedule.dart';
import 'notified.dart';
class Notify{
    FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); 

  initializeNotification() async {
   _configureLocalTimezone();
 

   // ignore: prefer_const_declarations
   final AndroidInitializationSettings initializationSettingsAndroid =
     const AndroidInitializationSettings("notify");

    final InitializationSettings initializationSettings =
        InitializationSettings(
  
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      // onDidReceiveNotificationResponse:selectNotification,
      );

  }
   void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  Future<void>displayNotification({required String title, required String body}) async {
    // ignore: avoid_print
    var androidPlatformChannelSpecifics =  const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

    var platformChannelSpecifics =  NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await flutterLocalNotificationsPlugin.show(
      0,
     title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }
   scheduledNotification(int hour,int minutes,Task task) async {
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.title,
         task.note,
        
         _convertTime(hour,minutes),
        //  tz.TZDateTime.now(tz.local).add(  Duration(seconds: minutes)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name',)),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             matchDateTimeComponents: DateTimeComponents.time,
             payload:   "${task.title}|"+"${task.note}|",
            );

   } 
  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    
    } else {
    print('object');
    }
     Get.to(()=>Notifypage(label:payload));
  }
  Future onDidReceiveLocalNotification(
      int id, String ?title, String ?body, String ?payload) async {
    // display a dialog with the notification details, tap ok to go to another page
   
   Get.to(()=>Container(color: Colors.white,));
  }
  
  tz.TZDateTime _convertTime(int hour ,int minutes) {
     tz.TZDateTime now = tz.TZDateTime.now(tz.local);
     tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if(scheduledDate.isBefore(now)){
      scheduledDate= scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}