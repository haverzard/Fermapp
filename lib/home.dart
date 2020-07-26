import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fermapp",
          style: TextStyle(
            color: Colors.blueGrey
          )
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(196, 248, 252, 1),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              height: 200,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenSize.width * 0.03, 0, screenSize.width * 0.03, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(
                              "Incoming Deadline",
                              style: TextStyle(
                                  fontSize: 24.0
                              ),
                            ),
                            alignment: Alignment(-1.0, 0),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 140,
                            padding: null,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(screenSize.width * 0.03, 0, screenSize.width * 0.03, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(
                              "Incoming Deadline",
                              style: TextStyle(
                                  fontSize: 24.0
                              ),
                            ),
                            alignment: Alignment(-1.0, 0),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 140,
                            padding: null,
                          )
                        ],
                      ),
                    ),
                  ],
              ),
            ),
          ]
        )
      )
    );
  }
}
