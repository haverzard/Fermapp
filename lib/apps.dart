import 'package:flutter/cupertino.dart';
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
      var temp = <Map>[];
      apps.forEach((e) {
        temp.add({
          'appName': e.appName,
          'appIcon': e is ApplicationWithIcon ? e.icon : null,
          'usageTimeHours': usage[e.packageName] ~/ 3600,
          'usageTimeMinutes': usage[e.packageName] % 3600 ~/ 60,
        });
        print(usage[e.packageName]);
        print(usage);
      });
      setState(() => appsList = temp);
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
//    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
            children: <Widget>[
              Container(
                height: 350,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: appsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          height: 75,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                                child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: MemoryImage(appsList[index]['appIcon'])
                                        )
                                    )
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${appsList[index]['appName']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('usage time: ${appsList[index]['usageTimeHours']}h ${appsList[index]['usageTimeMinutes']}m')
                                ],
                              ),
                            ],
                          )
                      );
                    }
                ),
              ),
            ]
        )
      );
  }
}