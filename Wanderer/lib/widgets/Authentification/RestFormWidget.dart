import 'package:Wanderer/Icons/my_flutter_app_icons.dart';
import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/widgets/Shared/AuthFormsStyle.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RestFormWidget extends StatefulWidget {
  final Function routeCode;
  final bool visible;
  final Function goToLogin;
  RestFormWidget(this.routeCode, this.visible, this.goToLogin);
  @override
  _RestFormState createState() => _RestFormState();
}

class _RestFormState extends State<RestFormWidget> {
  final _formKey = GlobalKey<FormState>();
  _RestFormState();
  bool _saving = false;

  var messageEmail = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    return WillPopScope(
      onWillPop: () {
        setState(() {
          messageEmail = "";
        });
        return widget.goToLogin();
      },
      child: ModalProgressHUD(
        color: Colors.black,
        progressIndicator: LoadingWidget(),
        opacity: 0.5,
        inAsyncCall: _saving,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                child: OutlineButton(
                  padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  borderSide: BorderSide(color: Colors.white70, width: 2),
                  child: Text('Send Reset Code',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white70)),
                  onPressed: () {
                    setState(() {
                      messageEmail = "";
                    });
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _saving = true;
                      });
                      AuthService.reset(email.text).then((value) => {
                            setState(() {
                              _saving = false;
                            }),
                            if (value.data['status'])
                              {widget.routeCode(email.text)}
                            else
                              {
                                setState(() {
                                  messageEmail = value.data['email'];
                                })
                              }
                          });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
