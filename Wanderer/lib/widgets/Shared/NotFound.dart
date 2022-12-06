import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    @required searchKey,
  }) : this.searchKey = searchKey;

  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      margin: EdgeInsets.only(bottom: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 100,
              width: 100,
              child: Opacity(
                  opacity: 0.7,
                  child:
                      Image(image: AssetImage("assets/Images/campfire.png")))),
          Center(
            child: Text("No Result Found For \"" + searchKey + "\"",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ));
  }
}
