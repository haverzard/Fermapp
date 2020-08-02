import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRuleForm extends StatefulWidget {
  final List apps;
  final SharedPreferences prefs;

  AddRuleForm(this.apps, this.prefs);

  @override
  _AddRuleFormState createState() => _AddRuleFormState(apps, prefs);
}

class _AddRuleFormState extends State<AddRuleForm> {
  final List apps;
  final SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  Application selectedApp;
  int hour, minute;

  _AddRuleFormState(this.apps, this.prefs);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var innerWidth = screenSize.width - 40;
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Container(
              height: 75,
              child: DropdownButtonFormField(
                isDense: false,
                itemHeight: 75,
                hint: Text('Select the app'),
                value: selectedApp,
                items: apps.map((value) {
//                {
//                  'appName': e.appName,
//                  'appIcon': e is ApplicationWithIcon ? e.icon : null,
//                  'usageTimeHours': usage[e.packageName] ~/ 3600,
//                  'usageTimeMinutes': usage[e.packageName] % 3600 ~/ 60,
//                };
                  return DropdownMenuItem(
                    child: Container(
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
                                          image: MemoryImage(value.icon)
                                      )
                                  )
                              ),
                            ),
                            Text(
                              '${value.appName}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                    ),
                    value: value,
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please choose an app';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() => selectedApp = value);
                },
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                'Duration',
                style: TextStyle(
                  fontSize: 20,
                )
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Container(
                    width: innerWidth * 0.5,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Hour',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an hour';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() => hour = int.parse(value));
                      },
                    ),
                  ),
                  Container(
                    width: innerWidth * 0.5,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Minute',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a minute';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() => minute = int.parse(value));
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: innerWidth,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (minute == 0 && hour == 0) {
                      Scaffold
                          .of(context)
                          .showSnackBar(
                          SnackBar(content: Text('Cannot process data')));
                    } else {
                      prefs.setInt(selectedApp.packageName, hour*3600+minute*60);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
