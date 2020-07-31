import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new time-rule'),
        elevation: 0,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: null,
          child: Text('Go back!'),
        ),
      ),
    );
  }
}