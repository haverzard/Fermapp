import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map> rulesList = [
    {
      'appName': 'APP NAME',
      'logoPath': 'assets/Lulu.PNG',
      'remainingTime': '30s',
    }
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
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
                    ),
                  ],
                ),
              ),
              Container(
                height: 350,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: rulesList.length,
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
                                            image: AssetImage('${rulesList[index]['logoPath']}')
                                        )
                                    )
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${rulesList[index]['appName']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text('remaining time: ${rulesList[index]['remainingTime']}')
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                width: 90,
                                child: RaisedButton(
                                    onPressed: () {},
                                    color: Color.fromRGBO(172, 238, 106, 1),
                                    textColor: Colors.black,
                                    child: Text('Edit')
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                width: 80,
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
                ),
              ),
            ]
        )
    );
  }
}
