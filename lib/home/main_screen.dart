import 'package:fermapp/home/home.dart';
import 'package:fermapp/home/apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget page = Home();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
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
        title: Text(
          'Fermapp',
          style: TextStyle(
            color: Colors.blueGrey
          )
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(196, 248, 252, 1),
      ),
      body: page,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_rule');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Apps'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Settings'),
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() => {
            currentIndex = index,
            if (index == 0) {
              page = Home()
            } else if (index == 1) {
              page = Apps()
            }
          });
        },
      )
    );
  }
}
