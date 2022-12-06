import 'package:Wanderer/Icons/my_flutter_app_icons.dart';
import 'package:Wanderer/Screens/CampingCenter/CampingCenterRole/CampingCenterProfileScreen.dart';
import 'package:Wanderer/Screens/Organization/OrganizationRole/OrganizationScreen.dart';
import 'package:Wanderer/Screens/User/ProfileScreen.dart';

import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:Wanderer/widgets/Shared/AuthFormsStyle.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginFormWidget extends StatefulWidget {
  final Function routeSignIn;
  final Function routeReset;
  LoginFormWidget(this.routeSignIn, this.routeReset);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  var messagePass = "";
  var messageEmail = "";

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  _LoginFormState();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      progressIndicator: LoadingWidget(),
      opacity: 0.4,
      inAsyncCall: _saving,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty !';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) return 'Invalid Email Adress !';
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: AuthStyle.inputStyle(
                    messageEmail, 'Email', MyFlutterApp.email),
                controller: email,
              ),
            ),
            Text(
              messageEmail,
              style: TextStyle(color: Colors.yellow),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty !';
                  }
                  if (value.length < 8)
                    return 'Password must be at least 8 caracteres long !';
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration: AuthStyle.inputStyle(
                    messagePass, 'Password', MyFlutterApp.key),
                obscureText: true,
                controller: password,
              ),
            ),
            Text(
              messagePass,
              style: TextStyle(color: Colors.yellow),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: () {
                  widget.routeReset();
                  messagePass = "";
                  messageEmail = "";
                },
                child: Text("Forgot Password ?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.lightBlue))),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: OutlineButton(
                padding: EdgeInsets.fromLTRB(130, 10, 130, 10),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                borderSide: BorderSide(color: Colors.white70, width: 2),
                child: Text('Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                onPressed: () {
                  setState(() {
                    messageEmail = '';
                    messagePass = '';
                  });
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _saving = true;
                    });
                    AuthService.login(email.text, password.text).then((val) {
                      setState(() {
                        _saving = false;
                      });
                      if (val.data != null) {
                        if (val.data['status']) {
                          LocalStorageService.setString('email', email.text);
                          LocalStorageService.setInt(
                              'role', val.data['user']['role']);
                          LocalStorageService.setString(
                              'name', val.data['user']['name']);
                          LocalStorageService.setString(
                              'image', val.data['user']['img']);

                          switch (val.data['user']['role']) {
                            case 0:
                              Navigator.of(context).pushNamed(
                                  ProfileScreen.routeName,
                                  arguments: {
                                    'flag': 'whatever',
                                    'email': null
                                  });
                              break;
                            case 1:
                              Navigator.of(context).pushNamed(
                                  OrganizationScreen.routeName,
                                  arguments: {
                                    'flag': 'whatever',
                                    'email': null
                                  });

                              break;
                            case 2:
                              Navigator.of(context).popAndPushNamed(
                                  CampingCenterProfileScreen.routeName);
                              break;
                          }
                        } else {
                          setState(() {
                            messageEmail = val.data['email'];
                            messagePass = val.data['pass'];
                          });
                        }
                      }
                    }).catchError((error) {});
                  }
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have An Account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  FlatButton(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () {
                        widget.routeSignIn();
                        messagePass = "";
                        messageEmail = "";
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
