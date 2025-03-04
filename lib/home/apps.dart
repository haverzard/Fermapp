import 'package:fermapp/home/app_usage_template.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';

class Apps extends StatefulWidget {
  @override
  _AppsState createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  List<Map> appsList = [];

  void getAppsData() async {
    try {
      var endDate = DateTime.now();
      var startDate = DateTime(endDate.year, endDate.month, endDate.day);
      endDate = DateTime(endDate.year, endDate.month, endDate.day+1);
      Map<String, double> usage = await AppUsage().fetchUsage(startDate, endDate);
      var apps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
      apps.forEach((e) async {
        setState(() => appsList.add({
          'appName': e.appName,
          'appIcon': e is ApplicationWithIcon ? e.icon : null,
          'usageTimeHours': (usage[e.packageName] ?? 0) ~/ 3600,
          'usageTimeMinutes': (usage[e.packageName] ?? 0) % 3600 ~/ 60,
        }));
      });
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
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: appsList.length,
                    itemBuilder: (context, index) {
                      return AppUsageWidget(appsList[index]);
                    }
                ),
              ),
            ]
        )
      );
  }
}