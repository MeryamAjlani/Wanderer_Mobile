import 'package:Wanderer/Services/CampingCenterService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';

import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingScreen extends StatefulWidget {
  static final String routeName = "/rateCenter";
  final String centerID; // receives the value
  bool alreadyrated;
  final Function() _refreshDetailScreenCallback;
  RatingScreen(
      {Key key,
      this.centerID,
      this.alreadyrated,
      Function refreshScreenDetailCallback})
      : this._refreshDetailScreenCallback = refreshScreenDetailCallback,
        super(key: key);
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

String savedName = '';
String savedImage = '';
double rating = 0.0;
String ratingContent = '';
String message = '';
String messageButton = '';
bool canSend = false;

class _RatingScreenState extends State<RatingScreen> {
  init() {
    if (widget.alreadyrated) {
      messageButton = "Update Rating";
    } else {
      messageButton = "Post your review";
    }
    savedImage = LocalStorageService.getString('image');
    savedName = LocalStorageService.getString('name');
  }

  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    print(widget._refreshDetailScreenCallback);
    return Container(
      padding: EdgeInsets.only(
          bottom: 40 + MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: CustomColor.backgroundColor,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(ImageService.imageUrl(
                                savedImage,
                                width: 150,
                                height: 150)),
                            fit: BoxFit.fill),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(savedName,
                              style: TextStyle(color: Colors.white))),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "Reviews are public and include your account information",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Row contents horizontally,
              crossAxisAlignment:
                  CrossAxisAlignment.center, //Center Row contents vertically,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                        setState(() {
                          rating = v;
                          if (v != 0.0) {
                            canSend = true;
                            message = 'Please give a Star Rating';
                          } else {
                            canSend = false;
                            message = '';
                          }
                        });
                      },
                      starCount: 5,
                      rating: 0,
                      size: 40.0,
                      isReadOnly: false,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half_outlined,
                      color: CustomColor.secondaryHighlight,
                      borderColor: CustomColor.secondaryHighlight,
                      spacing: 15.0),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: !canSend
                        ? Text(
                            message,
                            style: TextStyle(color: Colors.yellow),
                          )
                        : null),
                Container(
                  margin: EdgeInsets.only(top: 35, right: 25, left: 25),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white70, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.white70, width: 2.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                        ),
                        hintText: 'Describe your experience (optional)',
                        hintStyle: TextStyle(color: Colors.white70)),
                    maxLength: 350,
                    maxLengthEnforced: true,
                    maxLines: 8,
                    minLines: 1,
                    buildCounter: (_, {currentLength, maxLength, isFocused}) =>
                        Container(
                            child: Text(
                      currentLength.toString() + "/" + maxLength.toString(),
                      style: TextStyle(color: Colors.white70),
                    )),
                    onChanged: (val) {
                      setState(() {
                        ratingContent = val;
                      });
                    },
                  ),
                ),
                Container(
                  child: OutlineButton(
                    padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    borderSide: BorderSide(color: Colors.white70, width: 2),
                    child: Text(messageButton,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                    onPressed: () {
                      if (canSend) {
                        if (!widget.alreadyrated) {
                          CampingCenterService.rateCenter(
                            ratingContent,
                            rating,
                            savedName,
                            widget.centerID,
                          ).then((val) {
                            print("user rating refresh");

                            widget._refreshDetailScreenCallback();
                          });
                        } else {
                          CampingCenterService.modifyUserRating(
                                  ratingContent, rating, widget.centerID)
                              .then((val) {
                            print("user rating refresh");
                            widget._refreshDetailScreenCallback();
                          });
                        }
                        print("user rating refresh v2");
                        //update the detail screen

                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
