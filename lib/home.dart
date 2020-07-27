import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> appsList = [
    {
      "appName": "APP NAME",
      "logoPath": "assets/Lulu.PNG",
      "remainingTime": "30s",
    },
    {
      "appName": "APP NAME",
      "logoPath": "assets/Lulu.PNG",
      "remainingTime": "30s",
    },
    {
      "appName": "APP NAME",
      "logoPath": "assets/Lulu.PNG",
      "remainingTime": "30s",
    },
    {
      "appName": "APP NAME",
      "logoPath": "assets/Lulu.PNG",
      "remainingTime": "30s",
    },
    {
      "appName": "APP NAME",
      "logoPath": "assets/Lulu.PNG",
      "remainingTime": "30s",
    }
  ];

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
                                color: Color.fromRGBO(255, 111, 111, 1),
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
                                color: Color.fromRGBO(255, 111, 111, 1),
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
                                        image: AssetImage("${appsList[index]["logoPath"]}")
                                    )
                                )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${appsList[index]["appName"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text("remaining time: ${appsList[index]["remainingTime"]}")
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                            width: 90,
                            child: RaisedButton(
                                onPressed: () {},
                                color: Color.fromRGBO(172, 238, 106, 1),
                                textColor: Colors.black,
                                child: Text("Edit")
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            width: 80,
                            child: RaisedButton(
                                onPressed: () {},
                                color: Color.fromRGBO(87, 160, 246, 1),
                                textColor: Colors.black,
                                child: Text("Info")
                            ),
                          )
                        ],
                      )
                  );
                }
              ),
            ),
          ]
        )
      )
    );
  }
}
