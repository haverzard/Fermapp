import 'package:flutter/material.dart';

class DailyAnalyticsBar extends StatelessWidget {
  final Map usage;

  DailyAnalyticsBar(this.usage);

  @override
  Widget build(BuildContext context) {
    var totalUsage = 0;
    usage.forEach((_, v) {
      totalUsage += v.round();
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
              'Today Total Usage',
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
              width: screenSize.width * 0.9,
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
                                image: AssetImage('assets/Lulu.PNG')
                            )
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    width: screenSize.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total Usage',
                          overflow: TextOverflow.ellipsis,
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
                          '${totalUsage ~/ 3600}h ${totalUsage % 3600 ~/ 60}m',
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
