import 'package:Wanderer/Modules/CampingLocation.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/UrlService.dart';
import 'package:Wanderer/widgets/Shared/StaticDetailHeader.dart';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class BottomSheetLocationModal {
  static void show(BuildContext context, CampingLocation location) {
    Size screenSize = MediaQuery.of(context).size;
    showBottomSheet(
        backgroundColor: CustomColor.backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(screenSize.width * 0.21))),
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(screenSize.width * 0.2)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              StaticDetailHeader(
                centerName: location.name,
                city: location.city,
                imagePath: location.previewPicture,
                rating: location.avgRating,
                screenSize: screenSize,
                heightFactor: 0.6,
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton.icon(
                  padding: EdgeInsets.symmetric(horizontal: 23, vertical: 11),
                  icon: Icon(Icons.directions,
                      color: CustomColor.highlightText, size: 25),
                  onPressed: () {
                    UrlService.getDirection(
                        LatLng(location.coordLat, location.coordLon));
                  },
                  color: CustomColor.interactable,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  label: Text("Get Directions",
                      style: TextStyle(
                        color: CustomColor.highlightText,
                        fontSize: 15,
                      ))),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 13),
                  onPressed: () {},
                  color: CustomColor.interactable,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Text("More Details",
                      style: TextStyle(
                        color: CustomColor.highlightText,
                        fontSize: 15,
                      ))),
              SizedBox(
                height: 50,
              ),
            ]),
          );
        });
  }
}
