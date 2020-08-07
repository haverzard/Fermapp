import 'package:fermapp/rule/rule_form.dart';
import 'package:fermapp/loading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditRule extends StatefulWidget {
  final List apps;

  EditRule(this.apps);

  @override
  _EditRuleState createState() => _EditRuleState(apps);
}

class _EditRuleState extends State<EditRule> {
  final List apps;
  SharedPreferences prefs;
  bool finished = false;

  _EditRuleState(this.apps);

  void getAppsData() async {
    var tempPrefs = await SharedPreferences.getInstance();
    setState(() { prefs = tempPrefs; finished = true; });
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
        title: Text('Create time-rule'),
        elevation: 0,
      ),
      body: finished ? RuleForm(apps, prefs, true) : Loading(),
    );
  }
}