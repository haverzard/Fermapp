import 'package:fermapp/info/info.dart';
import 'package:fermapp/rule/edit_rule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRemainingWidget extends StatefulWidget {
  final Map app;

  AppRemainingWidget(this.app);

  @override
  _AppRemainingWidgetState createState() => _AppRemainingWidgetState(app);
}

class _AppRemainingWidgetState extends State<AppRemainingWidget> {
  Map app;

  _AppRemainingWidgetState(this.app);

  @override
  Widget build(BuildContext context) {
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
                          image: MemoryImage(app['appIcon'])
                      )
                  )
              ),
            ),
            Container(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${app['appName']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('remaining time:'),
                  Text(
                    app['overUsage'] ?
                      'over-usage'
                      : '${app['remainingTimeHours']}h ${app['remainingTimeMinutes']}m',
                    style: TextStyle(
                      fontSize: 15,
                      color: app['overUsage'] ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: 70,
              child: RaisedButton(
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EditRule([app['instance']]),
                    ));
                    var prefs = await SharedPreferences.getInstance();
                    var delta = prefs.getInt(app['packageName']) - app['usageTime'];
                    setState(() {
                      app = {
                        'appName': app['appName'],
                        'packageName': app['packageName'],
                        'appIcon': app['appIcon'],
                        'timeLimit': prefs.getInt(app['packageName']),
                        'usageTime': app['usageTime'],
                        'remainingTimeHours': delta ~/ 3600,
                        'remainingTimeMinutes': delta % 3600 ~/ 60,
                        'overUsage': delta < 0,
                        'instance': app['instance'],
                      };
                    });
                  },
                  color: Color.fromRGBO(172, 238, 106, 1),
                  textColor: Colors.black,
                  child: Text('Edit')
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: 70,
              child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AppInfo(app),
                    ));
                  },
                  color: Color.fromRGBO(87, 160, 246, 1),
                  textColor: Colors.black,
                  child: Text('Info')
              ),
            ),
          ],
        )
    );
  }
}
