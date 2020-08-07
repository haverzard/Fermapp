import 'package:fermapp/rule/rule_form.dart';
import 'package:fermapp/loading.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRule extends StatefulWidget {
  @override
  _AddRuleState createState() => _AddRuleState();
}

class _AddRuleState extends State<AddRule> {
  List apps = [];
  SharedPreferences prefs;
  bool finished = false;

  void getAppsData() async {
    var tempApps = await DeviceApps.getInstalledApplications(includeAppIcons: true);
    var tempPrefs = await SharedPreferences.getInstance();
    var unruledApps = [];
    tempApps.forEach((e) {
      if (tempPrefs.getInt(e.packageName) == null) {
        unruledApps.add(e);
      }
    });
    setState(() { apps = unruledApps; prefs = tempPrefs; finished = true; });
  }

  @override
  void initState() {
    super.initState();
    getAppsData();
  }

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
        title: Text('Create a new time-rule'),
        elevation: 0,
      ),
      body: finished ? RuleForm(apps, prefs, false) : Loading(),
    );
  }
}