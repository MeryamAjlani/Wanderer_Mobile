import 'package:Wanderer/widgets/Shared/AuthFormsStyle.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:Wanderer/Services/AuthService.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CodeFormWidget extends StatefulWidget {
  final Function routeReset;
  final Function routeChange;
  final String email;
  CodeFormWidget(this.routeReset, this.email, this.routeChange);
  @override
  _CodeFormState createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeFormWidget> {
  String message = '';
  bool _saving = false;
  final _formKey = GlobalKey<FormState>();
  _CodeFormState();
  TextEditingController code = TextEditingController();
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
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty !';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                decoration:
                    AuthStyle.inputStyle(message, 'Reset Code', Icons.refresh),
                controller: code,
              ),
            ),
            Text(
              message,
              style: TextStyle(color: Colors.yellow),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: OutlineButton(
                padding: EdgeInsets.fromLTRB(130, 10, 130, 10),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                borderSide: BorderSide(color: Colors.white70, width: 2),
                child: Text('Send',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white70)),
                onPressed: () {
                  setState(() {
                    message = '';
                  });
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _saving = true;
                    });
                    AuthService.confirmCode(code.text, widget.email)
                        .then((value) => {
                              setState(() {
                                _saving = false;
                              }),
                              if (value.data['message'] == 'pass')
                                {widget.routeChange(value.data['email'])}
                              else
                                {
                                  setState(() {
                                    this.message = value.data['message'];
                                  })
                                }
                            });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
