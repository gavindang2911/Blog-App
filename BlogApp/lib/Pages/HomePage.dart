import 'package:BlogApp/Screen/CreateProfileScreen.dart';
import 'package:BlogApp/Screen/HomeScreen.dart';
import 'package:BlogApp/Screen/ProfileScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0;
  List<Widget> widgets = [
    HomeScreen(),
    ProfileScreen(),
    // CreateProfileScreen(),
  ];
  List<String> titleString = ["Home Page", "Profile Page"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("@username"),
                ],
              ),
            ),
            ListTile(
              title: Text("all post"),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff4A37D2),
        title: Text(titleString[currentState]),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {})
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4A37D2),
        onPressed: null,
        child: Text(
          "+",
          style: TextStyle(fontSize: 35),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xff4A37D2),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: currentState == 0 ? Colors.white : Colors.white38,
                  ),
                  onPressed: () {
                    setState(() {
                      currentState = 0;
                    });
                  },
                  iconSize: 35,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: currentState == 1 ? Colors.white : Colors.white38,
                  ),
                  onPressed: () {
                    setState(() {
                      currentState = 1;
                    });
                  },
                  iconSize: 35,
                ),
              ],
            ),
          ),
        ),
      ),
      body: widgets[currentState],
    );
  }
}
