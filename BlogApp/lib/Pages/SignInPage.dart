import 'package:BlogApp/Common/Input_Field.dart';
import 'package:BlogApp/NetworkHandler.dart';
import 'package:BlogApp/Pages/SignUpPage.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _autovalidate;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _userController;
  bool vis = true;
  NetworkHandler networkHandler = NetworkHandler();
  String errorText;
  bool validate = false;
  bool circular = false;

  @override
  void initState() {
    super.initState();
    _autovalidate = false;
    _userController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.purple[900]],
              begin: const FractionalOffset(0.0, 1.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 100),
            child: Form(
              key: _key,
              autovalidate: _autovalidate,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
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
                    height: 12,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
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
                    onTapHiddenPassword: () {
                      setState(() {
                        vis = !vis;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Forgot password",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage()))
                        },
                                              child: Text(
                          "New User?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  circular
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                          child: Text('SIGN IN'),
                          onPressed: _validateFormAndLogin),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> _validateFormAndLogin() async {
    //TODO Another method for signin
  }

  String _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName is required';
    }
    return null;
  }
}
