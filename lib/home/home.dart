import 'package:fermapp/home/analytics_bar.dart';
import 'package:fermapp/home/app_remaining_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> rulesList = [];

  void getAppsData() async {
    try {
      var endDate = DateTime.now();
      var startDate = DateTime(endDate.year, endDate.month, endDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day+1);
      Map<String, double> usage = await AppUsage().fetchUsage(startDate, endDate);
      var apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
      var prefs = await SharedPreferences.getInstance();
      var temp = <Map>[];
      apps.forEach((e) {
        if (prefs.getInt(e.packageName) != null) {
          var delta = prefs.getInt(e.packageName) - usage[e.packageName];
          temp.add({
            'appName': e.appName,
            'appIcon': e is ApplicationWithIcon ? e.icon : null,
            'remainingTimeHours': delta ~/ 3600,
            'remainingTimeMinutes': delta % 3600 ~/ 60,
            'overUsage': delta < 0
          });
          print(temp);
        }
      });
      setState(() => rulesList = temp);
    }
    on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    getAppsData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    AnalyticsBar(),
                  ],
                ),
              ),
              Container(
                height: 350,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: rulesList.length,
                    itemBuilder: (context, index) {
                      return AppRemainingWidget(rulesList[index]);
                    }
                ),
              ),
            ]
        )
    );
  }
}
