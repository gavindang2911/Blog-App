import 'package:BlogApp/Pages/HomePage.dart';
import 'package:BlogApp/Pages/SignInPage.dart';
import 'package:BlogApp/Pages/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = SignInPage();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = SignInPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: page;
  }
}
