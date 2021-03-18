import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 50),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 8,
                        child: ListView(
                          children: <Widget>[
                            // logo,
                            // LabelCommon(
                            //   text: localizedText('emailTitle'),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: TextFormField(
                                autofocus: false,
                                autocorrect: false,
                                style: Theme.of(context).textTheme.body1,
                                decoration: InputDecoration(
                                  filled: true,
                                  focusColor: Colors.red,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      16.0, 15.0, 37.0, 15.0),
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(2),
                                    ),
                                    borderSide: new BorderSide(
                                      color: Colors.teal,
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(2),
                                    ),
                                    borderSide: new BorderSide(
                                      color: Colors.teal,
                                      width: 0.5,
                                    ),
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(2),
                                    ),
                                    borderSide: new BorderSide(
                                      color: Colors.teal,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // LabelCommon(
                            //   text: localizedText('passwordTitle'),
                            // ),
                            // InputFormCommon(
                            //     controller: _passwordController,
                            //     hintText: localizedText('passwordPlaceholder'),
                            //     fillColor: colorBackground,
                            //     isPassword: true,
                            //     validator: (value) => value.isEmpty
                            //         ? localizedText('emptyPasswordErrorMessage')
                            //         : null,
                            //     onSaved: (value) => _password = value.trim(),
                            //     focusNode: _passwordFocus,
                            //     onFieldSubmitted: (value) {
                            //       _passwordFocus.unfocus();
                            //       _validateAndSubmit();
                            //     }),
                            // rememberMe,
                            // ErrorMessage(errorMessage: _errorMessage),
                            // loginButton,
                            // StreamBuilder(
                            //   stream: widget.global.auth.authState,
                            //   builder: (context, AsyncSnapshot snapshot) {
                            //     if (snapshot.hasData) {
                            //       final state = snapshot.data;
                            //       if (state is LoadingState ||
                            //           state is LoadedState) {
                            //         return CircularProgress();
                            //       } else {
                            //         return EmptyContainer();
                            //       }
                            //     } else if (snapshot.hasError) {
                            //       return ErrorMessage(
                            //         errorMessage: snapshot.error.toString(),
                            //       );
                            //     } else {
                            //       return EmptyContainer();
                            //     }
                            //   },
                            // ),
                            // SizedBox(height: 20),
                            // Center(
                            //   child: DropDown(
                            //     global: widget.global,
                            //     onLanguageChanged: () {
                            //       setState(() {
                            //         print(
                            //             "---------------------- changed language");
                            //         _errorMessage = '';
                            //         _emailController.clear();
                            //         _passwordController.clear();
                            //       });
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
