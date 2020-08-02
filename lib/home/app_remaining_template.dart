import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRemainingWidget extends StatelessWidget {
  final Map app;

  AppRemainingWidget(this.app);
  
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
              width: 160,
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
                  onPressed: () {},
                  color: Color.fromRGBO(172, 238, 106, 1),
                  textColor: Colors.black,
                  child: Text('Edit')
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: 70,
              child: RaisedButton(
                  onPressed: () {},
                  color: Color.fromRGBO(87, 160, 246, 1),
                  textColor: Colors.black,
                  child: Text('Info')
              ),
            )
          ],
        )
    );
  }
}
