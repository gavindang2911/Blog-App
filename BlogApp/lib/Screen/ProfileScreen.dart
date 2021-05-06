import 'package:BlogApp/Screen/CreateProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BlogApp/NetworkHandler.dart';

import 'CreateProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkProfile();
    CreateProfileScreen();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    if (response["status"] == true) {
      setState(() {
        page = showProfile();
      });
    } else {
      setState(() {
        page = CreateProfileScreen(); // Show the create profile screen
      });
    }
  }

  Widget showProfile() {
    return Center(child: Text("Profile Data is available"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }
}
