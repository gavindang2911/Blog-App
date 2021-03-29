import 'package:BlogApp/Pages/SignUpPage.dart';
import 'package:flutter/material.dart';

import 'SignInPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: <Widget>[
                // SlideTransition(
                //   position: animation1,
                //   child: Text(
                //     "Hoai Dang",
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.w600,
                //       letterSpacing: 2,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 170,
                // ),
                Expanded(child: SignInPage()),
                // SizedBox(
                //   height: 20,
                // ),
                // boxContainer("assets/google.png", "Sign up with Google", null),
                // SizedBox(
                //   height: 20,
                // ),
                // boxContainer(
                //     "assets/facebook1.png", "Sign up with Facebook", null),
                // SizedBox(
                //   height: 20,
                // ),
                // // boxContainer(
                // //   "assets/email2.png",
                // //   "Sign up with Email",
                // //   onEmailClick,
                // // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       "Already have an account?",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 17,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         // Navigator.of(context).push(MaterialPageRoute(
                //         //   builder: (context) => SignInPage(),
                //         // ));
                //         onEmailClick();
                //       },
                //       child: Text(
                //         "Sign In",
                //         style: TextStyle(
                //             color: Colors.green.shade300,
                //             fontSize: 17,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     )
                //   ],
                // )
              ],
            )),
      ),
    );
  }

  // onEmailClick() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => SignUpPage(),
  //   ));
  // }

  // Widget boxContainer(String path, String text, onClick) {
  //   return InkWell(
  //     onTap: onClick,
  //     child: Container(
  //       height: 60,
  //       width: MediaQuery.of(context).size.width * 140,
  //       child: Card(
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           child: Row(
  //             children: <Widget>[
  //               Image.asset(
  //                 path,
  //                 height: 30,
  //                 width: 40,
  //               ),
  //               SizedBox(
  //                 width: 25,
  //               ),
  //               Text(
  //                 text,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.black87,
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
