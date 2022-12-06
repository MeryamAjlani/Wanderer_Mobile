import 'package:flutter/material.dart';

class NotFoundEvents extends StatelessWidget {
  const NotFoundEvents({@required org, @required message})
      : this.org = org,
        this.message = message;

  final String org;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 70,
              width: 70,
              child: Opacity(
                  opacity: 0.7,
                  child:
                      Image(image: AssetImage("assets/Images/campfire.png")))),
          Center(
            child: Text(org + " do not have any " + message + " yet !",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ));
  }
}
