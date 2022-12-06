import 'package:Wanderer/Icons/my_flutter_app_icons.dart';
import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/widgets/Shared/AuthFormsStyle.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  final Function routeLogIn;
  const ChangePassword(this.email, this.routeLogIn);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  String messagePass = '';
  String confirmation = '';
  bool _saving = false;
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
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
                  obscureText: true,
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
                      messagePass, 'New Password', MyFlutterApp.key),
                  controller: password),
            ),
            Text(
              messagePass,
              style: TextStyle(color: Colors.yellow),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty !';
                    }
                    if (value.length < 8)
                      return 'Password must be at least 8 caracteres long !';
                    if (value != password.text)
                      return 'Passwords do not match !';
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: AuthStyle.inputStyle(
                      confirmation, 'Confirm New Password', MyFlutterApp.check),
                  controller: confirm),
            ),
            Text(
              confirmation,
              style: TextStyle(color: Colors.yellow),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: OutlineButton(
                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                borderSide: BorderSide(color: Colors.white70, width: 2),
                child: Text('Change Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                onPressed: () {
                  setState(() {
                    confirmation = '';
                    messagePass = '';
                  });
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _saving = true;
                    });
                    AuthService.sendNewPassword(widget.email, password.text)
                        .then((val) {
                      if (val.data != null) {
                        setState(() {
                          _saving = false;
                        });
                        if (val.data['status']) {
                          widget.routeLogIn();
                        } else {
                          setState(() {
                            confirmation = val.data['confirmation'];
                            messagePass = val.data['password'];
                          });
                        }
                      }
                    }).catchError((error) {});
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
