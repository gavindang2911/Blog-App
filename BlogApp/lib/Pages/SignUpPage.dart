import 'package:BlogApp/Common/Input_Field.dart';
import 'package:BlogApp/NetworkHandler.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    validator: _validateEmail,
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
                      "Email Adrress",
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .apply(color: Colors.white),
                    ),
                  ),
                  InputFormCommon(
                    validator: _validateEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Enter Email Address",
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
                  circular
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0)),
                          child: Text('LOGIN'),
                          onPressed: _validateFormAndLogin),
                ],
              ),
            ),
          )),
    );
  }

  checkUser() async {
    if (_userController.text.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        errorText = "Username can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkUsername/${_userController.text}");
      if (response['Status']) {
        setState(() {
          circular = false;
          validate = false;
          errorText = "Username already taken";
        });
      } else {
        setState(() {
          validate = true;
        });
      }
    }
  }

  Future<void> _validateFormAndLogin() async {
    setState(() {
      circular = true;
    });
    await checkUser();
    // Get form state from the global key
    var formState = _key.currentState;

    // check if form is valid
    if (formState.validate() && validate) {
      ///ToDo send the data to rest server
      Map<String, String> data = {
        "Username": _userController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await networkHandler.post("/user/register", data);
      setState(() {
        circular = false;
      });
      print('Form is valid');
    } else {
      // show validation errors
      // setState forces our [State] to rebuild
      setState(() {
        circular = false;
        _autovalidate = true;
      });
    }
  }

  String _validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName is required';
    }
    return null;
  }

  String _validateEmail(String value) {
    if (value == null || value == '') {
      return 'Email is required';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }
}
