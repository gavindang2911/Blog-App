import 'dart:convert';
import 'dart:developer';

import 'package:BlogApp/Common/Input_Field.dart';
import 'package:BlogApp/NetworkHandler.dart';
import 'package:BlogApp/Pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'HomePage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _autovalidate;
  TextEditingController _passwordController;
  TextEditingController _userController;
  bool vis = true;
  NetworkHandler networkHandler = NetworkHandler();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _autovalidate = false;
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff4A37D2),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 35),
          child: Form(
            key: _key,
            autovalidate: _autovalidate,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign in",
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      color: Colors.white60),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  child: Text(
                    "User name",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .apply(color: Colors.white),
                  ),
                ),
                InputFormCommon(
                  validator: null,
                  controller: _userController,
                  hintText: "Enter User Name",
                  hasErrorText: validate,
                  errorText: errorText,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  child: Text(
                    "Password",
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .apply(color: Colors.white),
                  ),
                ),
                InputFormCommon(
                  validator: (val) => _validateRequired(val, 'Password'),
                  controller: _passwordController,
                  hintText: "Enter Password",
                  isPassword: vis,
                  hasErrorText: validate,
                  errorText: errorText,
                  onTapHiddenPassword: () {
                    setState(() {
                      vis = !vis;
                    });
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Text("Forgot password",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16,
                ),
                circular
                    ? Container(
                        width: 24.0,
                        height: 44.0,
                        padding:
                            EdgeInsets.only(top: 20.0, left: 50, right: 50),
                        child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey)))
                    : RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8.0)),
                        child: Text('SIGN IN'),
                        onPressed: _validateFormAndLogin),
                SizedBox(
                  height: 16,
                ),
                boxContainer("assets/google.png", "Sign up with Google", null),
                SizedBox(
                  height: 16,
                ),
                boxContainer(
                    "assets/facebook1.png", "Sign up with Facebook", null),
                SizedBox(
                  height: 46,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "New User ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => SignInPage(),
                        // ));
                        onSignUpClick();
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.green.shade300,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSignUpClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  Future<void> _validateFormAndLogin() async {
    setState(() {
      circular = true;
    });
    //TODO Another method for signin
    Map<String, String> data = {
      "username": _userController.text,
      "password": _passwordController.text,
    };
    var responseLogin = await networkHandler.post("/user/login", data);
    if (responseLogin.statusCode == 200 || responseLogin.statusCode == 201) {
      Map<String, dynamic> output = json.decode(responseLogin.body);
      print(output["token"]);
      await storage.write(key: "token", value: output["token"]);
      setState(() {
        validate = true;
        circular = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    } else {
      print(responseLogin.body);
      String output = json.decode(responseLogin.body);
      setState(() {
        validate = false;
        errorText = output;
        circular = false;
      });
    }
  }

  String _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName is required';
    }
    return null;
  }

  Widget boxContainer(String path, String text, onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 140,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                Image.asset(
                  path,
                  height: 30,
                  width: 40,
                ),
                SizedBox(
                  width: 25,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
