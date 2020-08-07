import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuleForm extends StatefulWidget {
  final List apps;
  final SharedPreferences prefs;
  final bool isEdit;

  RuleForm(this.apps, this.prefs, this.isEdit);

  @override
  _RuleFormState createState() => _RuleFormState();
}

class _RuleFormState extends State<RuleForm> {
  final _formKey = GlobalKey<FormState>();
  Application selectedApp;
  int hour, minute;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      setState(() {
        hour = widget.prefs.getInt(widget.apps[0].packageName) ~/ 3600;
        minute = widget.prefs.getInt(widget.apps[0].packageName) % 3600 ~/ 60;
        selectedApp = widget.apps[0];
      });
    }
  }

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
                items: widget.apps.map((value) {
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
                      initialValue: hour != null ? hour.toString() : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an hour';
                        }
                        var temp = int.parse(value);
                        if (temp < 0 || temp > 60) {
                          return 'Please enter a correct hour';
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
                      initialValue: minute != null ? minute.toString() : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a minute';
                        }
                        var temp = int.parse(value);
                        if (temp < 0 || temp > 60) {
                          return 'Please enter a correct minute';
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (minute == 0 && hour == 0) {
                      Scaffold
                          .of(context)
                          .showSnackBar(
                          SnackBar(content: Text('Cannot process data')));
                    } else {
                      await widget.prefs.setInt(selectedApp.packageName, hour*3600+minute*60);
                      await widget.prefs.setBool(selectedApp.packageName+'-activated', false);
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
