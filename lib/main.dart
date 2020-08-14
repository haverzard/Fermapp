import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fermapp/home/main_screen.dart';
import 'package:fermapp/rule/add_rule.dart';

void usageScheduler(String _arg) async  {
  var prefs = await SharedPreferences.getInstance();
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(initializationSettingsAndroid, null);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'fermapp_app', 'fermapp_usage_warning',
      'Fermapp Usage Warning Notification',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker');
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, null);

  Timer.periodic(Duration(seconds:5), (timer) async {
    var endDate = DateTime.now();
    var startDate = DateTime(endDate.year, endDate.month, endDate.day);

    endDate = DateTime(endDate.year, endDate.month, endDate.day+1);
    Map<String, double> usage = await AppUsage().fetchUsage(startDate, endDate);
    var apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
    apps.forEach((e) async {
      var rule = prefs.getInt(e.packageName);
      if (rule != null) {
        if (rule <= usage[e.packageName]) {
          if (!prefs.getBool(e.packageName + '-activated')) {
            await prefs.setBool(e.packageName + '-activated', true);
            await flutterLocalNotificationsPlugin.show(
                0, 'Fermapp Usage Warning',
                "${e.appName}'s usage time has reached the limit time",
                platformChannelSpecifics);
          }
        } else {
          if (prefs.getBool(e.packageName + '-activated')) {
            await prefs.setBool(e.packageName + '-activated', false);
          }
        }
      }
      var indicator = prefs.getBool('global-fermapp') ?? false;
      var totalUsage = 0;
      usage.forEach((_, v) {
        totalUsage += v.round();
      });

      if (totalUsage >= 36000) {
        if (!indicator) {
          await prefs.setBool('global-fermapp', true);
          await flutterLocalNotificationsPlugin.show(
              0, 'Fermapp Usage Warning',
              'Today total usage time has reached 10 hours',
              platformChannelSpecifics);
        }
      } else {
        if (indicator) {
          await prefs.setBool('global-fermapp', false);
        }
      }
    });

  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  usageScheduler('scheduler');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainScreen(),
        '/add_rule': (context) => AddRule()
      }
    );
  }
}

