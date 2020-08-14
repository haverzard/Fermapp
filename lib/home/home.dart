import 'package:fermapp/home/daily_analytics_bar.dart';
import 'package:fermapp/home/app_remaining_template.dart';
import 'package:fermapp/home/most_used_analytics_bar.dart';
import 'package:fermapp/loading.dart';
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
  Map<String, double> usage;
  List<Map> apps;
  bool finished = false;

  void getAppsData() async {
    try {
      var endDate = DateTime.now();
      var startDate = DateTime(endDate.year, endDate.month, endDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day+1);
      Map<String, double> tempUsage = await AppUsage().fetchUsage(startDate, endDate);
      var tempApps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
      var prefs = await SharedPreferences.getInstance();
      var tempRules = <Map>[];
      var tempAppsListed = <Map>[];
      tempApps.forEach((e) {
        if (prefs.getInt(e.packageName) != null) {
          var delta = prefs.getInt(e.packageName) - tempUsage[e.packageName];
          tempRules.add({
            'appName': e.appName,
            'packageName': e.packageName,
            'timeLimit': prefs.getInt(e.packageName),
            'usageTime': tempUsage[e.packageName] ?? 0,
            'appIcon': e is ApplicationWithIcon ? e.icon : null,
            'remainingTimeHours': delta ~/ 3600,
            'remainingTimeMinutes': delta % 3600 ~/ 60,
            'overUsage': delta < 0,
            'instance': e,
          });
        }
        tempAppsListed.add({
          'appName': e.appName,
          'usageTime': tempUsage[e.packageName] ?? 0,
          'appIcon': e is ApplicationWithIcon ? e.icon : null,
        });
      });
      setState(() { rulesList = tempRules; usage = tempUsage; apps = tempAppsListed; finished = true; });
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
    return !finished ?
      Loading()
      : SafeArea(
        child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    DailyAnalyticsBar(usage),
                    MostUsedAnalyticsBar(apps),
                  ],
                )
              ),
              Container(
                height: MediaQuery.of(context).size.width-250,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: rulesList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(index.toString()),
                        child: AppRemainingWidget(rulesList[index]),
                        onDismissed: (_) async {
                          var prefs = await SharedPreferences.getInstance();
                          await prefs.remove(rulesList[index]['packageName']);
                          await prefs.remove(rulesList[index]['packageName']+'-activated');
                        },
                      );
                    }
                ),
              ),
            ]
        )
    );
  }
}
