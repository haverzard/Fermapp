import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  final Map app;

  AppInfo(this.app);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.orientation == Orientation.landscape) {
      return const Text("Doesn't support landscape");
    }
    return getPortrait(context);
  }

  Widget getPortrait(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App information'),
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
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
                      SizedBox(height: 20),
                      Text(
                        '${app['appName']}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Text(
                          'Usage Time',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Text('${app['usageTime'] ~/ 3600}h ${app['usageTime'] % 3600 ~/ 60}m'),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 30,
                        child: Text(
                          'Usage Time Limit',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        child: Text('${app['timeLimit'] ~/ 3600}h ${app['timeLimit'] % 3600 ~/ 60}m'),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          )
      ),
    );
  }
}
