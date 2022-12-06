import 'dart:io';

import 'package:Wanderer/Services/CampingCenterService.dart';

import 'package:Wanderer/Services/EventService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:Wanderer/Services/Utility/DateService.dart';

class CampingCenterEditorHeader extends StatefulWidget {
  final String _imagePath;
  final Size _screenSize;
  final String _name;
  final String _city;
  final ScrollController _scrollController;
  final double _rating;
  final int _role;
  final DateTime _date;
  final String _id;
  final Function _refreshCenterDataCallback;
  CampingCenterEditorHeader(
      {@required String imagePath,
      @required Size screenSize,
      @required String centerName,
      @required String city,
      @required ScrollController controller,
      @required int role,
      double rating,
      String id,
      DateTime date,
      @required Function refreshCenterDataCallback})
      : this._imagePath = imagePath,
        this._screenSize = screenSize,
        this._name = centerName,
        this._city = city,
        this._scrollController = controller,
        this._rating = rating,
        this._date = date,
        this._id = id,
        this._role = role,
        this._refreshCenterDataCallback = refreshCenterDataCallback;

  @override
  _CampingCenterEditorHeaderState createState() =>
      _CampingCenterEditorHeaderState();
}

class _CampingCenterEditorHeaderState extends State<CampingCenterEditorHeader> {
  bool loadingPicture = false;
  double scrollOffset = 0.0;
  double halfWidth;
  double quarterWidth;
  double fifthWidth;
  double fullWidth;
  File croppedImage;
  @override
  void initState() {
    super.initState();
    fullWidth = widget._screenSize.width;
    halfWidth = fullWidth * 0.5;
    quarterWidth = halfWidth * 0.5;
    fifthWidth = fullWidth * 0.2;
    if (widget._scrollController != null)
      widget._scrollController.addListener(_setScroll);
  }

  void _setScroll() {
    double offset = widget._scrollController.offset;
    if (offset > quarterWidth) offset = quarterWidth;
    if (scrollOffset != offset) {
      setState(() {
        scrollOffset = offset;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget._scrollController.removeListener(_setScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -scrollOffset,
      child: Stack(
        children: [
          Container(
            width: fullWidth,
            height: halfWidth + fullWidth * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(fifthWidth),
              ),
              color: CustomColor.lightBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          loadingPicture
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(quarterWidth)),
                  child: Container(
                    width: fullWidth,
                    height: halfWidth,
                    child: Center(
                      child: PlaceholderLines(
                        animationOverlayColor: Colors.grey.withAlpha(150),
                        maxWidth: 1,
                        minWidth: 1,
                        count: 1,
                        animate: true,
                        lineHeight: halfWidth,
                        color: CustomColor.lightBackground,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: fullWidth,
                  height: halfWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(quarterWidth)),
                    image: DecorationImage(
                        image: croppedImage == null
                            ? NetworkImage(widget._imagePath)
                            : FileImage(croppedImage),
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.cover),
                  ),
                ),
          Container(
            width: fullWidth,
            height: halfWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(quarterWidth)),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent
                    ])),
          ),
          Container(
            padding: EdgeInsets.only(left: fullWidth * 0.17, right: 20),
            width: fullWidth,
            height: halfWidth + fullWidth * 0.17,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: fullWidth * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget._name,
                        style: TextStyle(
                            color: CustomColor.highlightText,
                            fontWeight: FontWeight.w400,
                            fontSize: 30),
                      ),
                      !loadingPicture
                          ? Container(
                              child: croppedImage == null
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.camera_enhance,
                                        color: CustomColor.interactable,
                                        size: 30,
                                      ),
                                      onPressed: () async {
                                        var cropped =
                                            await ImageService.pickImage();
                                        setState(() {
                                          croppedImage = cropped;
                                        });
                                      })
                                  : Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                croppedImage = null;
                                              });
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                loadingPicture = true;
                                              });
                                              if (widget._role == 2)
                                                CampingCenterService
                                                        .uploadPicture(
                                                            croppedImage)
                                                    .then((value) {
                                                  widget
                                                      ._refreshCenterDataCallback(
                                                          value.data['image']);
                                                  croppedImage = null;
                                                  setState(() {
                                                    loadingPicture = false;
                                                  });
                                                });
                                              else
                                                EventService
                                                        .updateOrgEventPicture(
                                                            croppedImage,
                                                            widget._id)
                                                    .then((value) {
                                                  widget
                                                      ._refreshCenterDataCallback(
                                                          value.data['image']);
                                                  croppedImage = null;
                                                  setState(() {
                                                    loadingPicture = false;
                                                  });
                                                });
                                            })
                                      ],
                                    ))
                          : Container()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: fullWidth * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 22,
                            color: CustomColor.primaryText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            child: Text(
                              widget._city,
                              style: TextStyle(
                                  color: CustomColor.primaryText, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (widget._role == 2)
                        ? Container(
                            padding: EdgeInsets.only(bottom: fullWidth * 0.06),
                            child: SmoothStarRating(
                              isReadOnly: true,
                              allowHalfRating: true,
                              borderColor: CustomColor.secondaryText,
                              rating: widget._rating,
                              size: fullWidth * 0.07,
                              color: CustomColor.primaryText,
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(bottom: fullWidth * 0.048),
                            child: Text(
                              widget._date.humanReadableDate(),
                              style:
                                  TextStyle(color: CustomColor.secondaryText),
                            )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
