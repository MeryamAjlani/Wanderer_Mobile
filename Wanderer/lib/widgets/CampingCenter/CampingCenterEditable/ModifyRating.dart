import 'package:Wanderer/Modules/RatingModule.dart';
import 'package:Wanderer/Screens/CampingCenter/RatingScreen.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';

import '../RatingWidget.dart';

class ModifyRating extends StatefulWidget {
  final Function() _refreshScreenCallback;
  final RatingModule userRating; // receives the value
  final String centerID;
  ModifyRating(
      {Key key,
      this.userRating,
      this.centerID,
      Function() refreshScreenCallback})
      : this._refreshScreenCallback = refreshScreenCallback,
        super(key: key);
  @override
  _ModifyRatingState createState() => _ModifyRatingState();
}

class _ModifyRatingState extends State<ModifyRating> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingWidget(widget.userRating),
        Container(
          child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: Icon(
                  Icons.border_color,
                  color: CustomColor.interactable,
                ),
                label: Text(
                  "Modify Your Rating",
                  style: TextStyle(
                      color: CustomColor.interactable,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return RatingScreen(
                            refreshScreenDetailCallback:
                                widget._refreshScreenCallback,
                            centerID: widget.centerID,
                            alreadyrated: true);
                      });
                },
              )),
        )
      ],
    );
  }
}
