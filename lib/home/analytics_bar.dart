import 'package:flutter/material.dart';

class AnalyticsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width * 0.03, 0, screenSize.width * 0.03, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Text(
              'Incoming Deadline',
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
                                image: AssetImage('assets/Lulu.PNG')
                            )
                        ),
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'APP NAME',
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
                          '2:00:30',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'remaining time',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '2:00:30',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        )
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
