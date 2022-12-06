import 'package:Wanderer/Modules/CampingLocation.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';

class CampingLocationMarker extends StatelessWidget {
  final CampingLocation _campingLocation;
  CampingLocationMarker(this._campingLocation);

  CampingLocation getInfo() {
    return _campingLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: Colors.black54, blurRadius: 1, offset: Offset(1, 1))
      ]),
      child: CircleAvatar(
        backgroundColor: CustomColor.interactable,
        child: Container(
          padding: EdgeInsets.all(2),
          child: Container(
              //width: 30,
              //height: 30,
              //margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
              decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(_campingLocation.smallPicture),
                fit: BoxFit.fill),
          )),
        ),
      ),
    );
  }
}
