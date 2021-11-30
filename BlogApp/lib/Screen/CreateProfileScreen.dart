import 'dart:io';

import 'package:BlogApp/Common/Input_Field.dart';
import 'package:BlogApp/NetworkHandler.dart';
import 'package:BlogApp/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key key}) : super(key: key);

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  var log = Logger();
  final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _key = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _professionController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _titlelineController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _key,
      child: ListView(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 35),
        children: <Widget>[
          imageProfile(),
          SizedBox(
            height: 25,
          ),
          InputFormCommon(
            validator: (value) {
              if (value.isEmpty) return "Name can't be empty";

              return null;
            },
            controller: _nameController,
            hintText: "Enter Name",
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            borderTextColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          InputFormCommon(
            validator: (value) {
              if (value.isEmpty) return "Profession can't be empty";

              return null;
            },
            controller: _professionController,
            hintText: "Enter Profession",
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            borderTextColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          InputFormCommon(
            validator: (value) {
              if (value.isEmpty) return "DOB can't be empty";

              return null;
            },
            controller: _dobController,
            hintText: "Enter DOB",
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            borderTextColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          InputFormCommon(
            validator: (value) {
              if (value.isEmpty) return "Title can't be empty";

              return null;
            },
            controller: _titlelineController,
            hintText: "Enter Titleline",
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            borderTextColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          InputFormCommon(
            validator: (value) {
              if (value.isEmpty) return "About can't be empty";

              return null;
            },
            controller: _aboutController,
            hintText: "Enter About",
            icon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            borderTextColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                circular = true;
              });
              if (_key.currentState.validate()) {
                Map<String, String> data = {
                  "name": _nameController.text,
                  "profession": _professionController.text,
                  "DOB": _dobController.text,
                  "titleline": _titlelineController.text,
                  "about": _aboutController.text,
                };
                var response = await networkHandler.post("/profile/add", data);
                if (response.statusCode == 200 || response.statusCode == 201) {
                  if (_imageFile != null) {
                    var imageResponse = await networkHandler.patchImage(
                        "/profile/add/image", _imageFile.path);
                    if (imageResponse.statusCode == 200) {
                      setState(() {
                        circular = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    }
                  } else {
                    setState(() {
                      circular = false;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  }
                }
              }
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: circular
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
        //)
      ),
    ));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 55.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/google.png")
                : FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
