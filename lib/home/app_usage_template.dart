import 'package:flutter/material.dart';

class AppUsageWidget extends StatelessWidget {
  final Map app;

  AppUsageWidget(this.app);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width * 0.7,
                  child: Text(
                    '${app['appName']}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text('usage time: ${app['usageTimeHours']}h ${app['usageTimeMinutes']}m')
              ],
            ),
          ],
        )
    );
  }
}
