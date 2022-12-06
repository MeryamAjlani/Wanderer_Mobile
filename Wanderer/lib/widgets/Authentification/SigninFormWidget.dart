import 'package:Wanderer/Icons/my_flutter_app_icons.dart';
import 'package:Wanderer/Screens/User/ProfileScreen.dart';

import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:Wanderer/widgets/Shared/AuthFormsStyle.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SigninFormWidget extends StatefulWidget {
  final Function routeLogIn;
  SigninFormWidget(this.routeLogIn);
  @override
  _SigninFormWidgetState createState() => _SigninFormWidgetState();
}

class _SigninFormWidgetState extends State<SigninFormWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  var messagePass = "", messageEmail = "", messageFullName = "";
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      progressIndicator: LoadingWidget(),
      opacity: 0.5,
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
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: AuthStyle.inputStyle(
                      messageFullName, 'Full Name', MyFlutterApp.user),
                  controller: name),
            ),
            Text(
              messageFullName,
              style: TextStyle(color: Colors.yellow),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                style: TextStyle(color: Colors.white70),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: OutlineButton(
                padding: EdgeInsets.fromLTRB(125, 10, 125, 10),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                borderSide: BorderSide(color: Colors.white70, width: 2),
                child: Text('Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                onPressed: () {
                  setState(() {
                    messageEmail = '';
                    messagePass = '';
                    messageFullName = '';
                  });
                  //need to add roles here
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _saving = true;
                    });
                    AuthService.register(email.text, password.text, name.text)
                        .then((val) {
                      setState(() {
                        _saving = false;
                      });
                      if (val.data != null) {
                        print(val.data);
                        if (val.data['status']) {
                          LocalStorageService.setString('email', email.text);
                          LocalStorageService.setInt(
                              'role', val.data['user']['role']);
                          LocalStorageService.setString(
                              'name', val.data['user']['name']);
                          LocalStorageService.setString(
                              'image', val.data['user']['img']);
                          Navigator.of(context).pushNamed(
                              ProfileScreen.routeName,
                              arguments: {'flag': 'whatever', 'email': null});
                        } else {
                          setState(() {
                            messageEmail = val.data['email'];
                            messagePass = val.data['pass'];
                            messageFullName = val.data['name'];
                          });
                        }
                      }
                    }).catchError((error) {});
                  }
                },
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Have An Account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  FlatButton(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      onPressed: () {
                        widget.routeLogIn();
                        setState(() {
                          messagePass = "";
                          messageEmail = "";
                          messageFullName = "";
                        });
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
