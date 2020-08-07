import 'package:flutter/material.dart';

class MostUsedAnalyticsBar extends StatelessWidget {
  final List apps;

  MostUsedAnalyticsBar(this.apps);

  @override
  Widget build(BuildContext context) {
    var maxUsage = 0;
    var app;
    apps.forEach((e) {
      var tempUsage = e['usageTime'].round();
      if (maxUsage <= tempUsage) {
        maxUsage = tempUsage;
        app = e;
      }
    });
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width * 0.03, 0, screenSize.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(
              'Today Most Used App',
              style: TextStyle(
                  fontSize: 24.0
              ),
            ),
            alignment: Alignment(-1.0, 0),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 111, 111, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 140,
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(25),
                      child: Container(
                        width: 90,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 111, 111, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: MemoryImage(app['appIcon'])
                            )
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${app['appName']}',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'usage time',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${maxUsage ~/ 3600}h ${maxUsage % 3600 ~/ 60}m',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
