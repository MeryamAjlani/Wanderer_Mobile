import 'package:Wanderer/Screens/CampingCenter/RatingScreen.dart';

import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';

class RatingBottomSheet extends StatefulWidget {
  final String centerID; // receives the value
  final Function _refreshScreenCallback;
  RatingBottomSheet({
    final Function() refreshScreenCallback,
    Key key,
    this.centerID,
  })  : this._refreshScreenCallback = refreshScreenCallback,
        super(key: key);
  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewPadding.bottom),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              textColor: CustomColor.highlightText,
              color: CustomColor.interactable,
              onPressed: () {
                print("hello " + widget._refreshScreenCallback.toString());
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return RatingScreen(
                        centerID: widget.centerID,
                        alreadyrated: false,
                        refreshScreenDetailCallback:
                            widget._refreshScreenCallback,
                      );
                    });
              },
              child: Text(
                "Write Your Review",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ));
  }
}
