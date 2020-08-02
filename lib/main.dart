import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fermapp/home/main_screen.dart';
import 'package:fermapp/add_rule/add_rule.dart';

void usageScheduler(String _arg) async  {
  Timer.periodic(Duration(seconds:5), (timer) async {
    var endDate = DateTime.now();
    var startDate = DateTime(endDate.year, endDate.month, endDate.day);
    var prefs = await SharedPreferences.getInstance();
    endDate = DateTime(endDate.year, endDate.month, endDate.day+1);
    Map<String, double> usage = await AppUsage().fetchUsage(startDate, endDate);
    var apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
    apps.forEach((e) {
      var rule = prefs.getInt(e.packageName) ?? -1;
      if (rule <= usage[e.packageName]) {
        print('Do something here');
      } else if (rule-300 <= usage[e.packageName]) {
        print('Warning here?');
      }
    });
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterIsolate.spawn(usageScheduler, 'scheduler');
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

