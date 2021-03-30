import 'package:BlogApp/Common/Input_Field.dart';
import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _professionController;
  TextEditingController _dobController;
  TextEditingController _titlelineController;
  TextEditingController _aboutController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 35),
        child: Form(
            key: _key,
            child: ListView(
              children: <Widget>[
                InputFormCommon(
                  validator: null,
                  controller: _nameController,
                  hintText: "Enter Name",
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InputFormCommon(
                  validator: null,
                  controller: _professionController,
                  hintText: "Enter Profession",
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InputFormCommon(
                  validator: null,
                  controller: _dobController,
                  hintText: "Enter DOB",
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InputFormCommon(
                  validator: null,
                  controller: _titlelineController,
                  hintText: "Enter Titleline",
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InputFormCommon(
                  validator: null,
                  controller: _aboutController,
                  hintText: "Enter About",
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
    );
  }
}
