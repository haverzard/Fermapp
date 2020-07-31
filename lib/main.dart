import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fermapp/main_screen.dart';
import 'package:fermapp/add_rule.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainScreen(),
        '/add_rule': (context) => AddRule()
      }
    );
  }
}

