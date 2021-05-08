import 'package:BlogApp/Model/profileModel.dart';
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
  bool circular = true;
  Widget page = CircularProgressIndicator();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkProfile();
    // CreateProfileScreen();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    if (response["status"] == true) {
      fetchData();
      setState(() {
        page = showProfile();
      });
    } else {
      setState(() {
        page = CreateProfileScreen(); // Show the create profile screen
      });
    }
  }

  void fetchData() async {
    var response = await networkHandler.get("/profile/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  Widget showProfile() {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        //   color: Colors.black,
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                head(),
                Divider(
                  thickness: 0.8,
                ),
                otherDetails("About", profileModel.about),
                otherDetails("Name", profileModel.name),
                otherDetails("Profession", profileModel.profession),
                otherDetails("DOB", profileModel.DOB),
                Divider(
                  thickness: 0.8,
                ),
                SizedBox(
                  height: 20,
                ),
                // Blogs(
                //   url: "/blogpost/getOwnBlog",
                // ),
              ],
            ),
    );
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkHandler().getImage(profileModel.username),
            ),
          ),
          Text(
            profileModel.username,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(profileModel.titleline)
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page,
    );
  }
}
