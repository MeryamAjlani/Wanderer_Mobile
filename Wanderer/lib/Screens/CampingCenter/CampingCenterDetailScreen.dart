import 'dart:ui';

import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Modules/RatingModule.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:Wanderer/Services/Utility/UrlService.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterDetailHeader.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterEditable/ModifyRating.dart';
import 'package:Wanderer/widgets/CampingCenter/MapPreviewWidget.dart';
import 'package:Wanderer/widgets/CampingCenter/PriceItemList.dart';
import 'package:Wanderer/widgets/CampingCenter/RatingBottomSheet.dart';
import 'package:Wanderer/widgets/CampingCenter/RatingWidget.dart';
import 'package:Wanderer/widgets/CampingCenter/ReadMoreText.dart';
import 'package:Wanderer/widgets/CampingCenter/TitleText.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/ClippingStyled.dart';

import 'CenterMakeReservationScreen.dart';
import 'package:Wanderer/Services/CampingCenterService.dart';

import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Wanderer/Modules/ListItemCenter.dart';

class CampingCenterDetailScreen extends StatefulWidget {
  static final String routeName = "/center";
  @override
  _CampingCenterDetailScreenState createState() =>
      _CampingCenterDetailScreenState();
}

class _CampingCenterDetailScreenState extends State<CampingCenterDetailScreen> {
  ScrollController scrollController;
  bool _pricesLoaded = false;
  bool _ratingsLoaded = false;
  bool _alreadyRated = false;
  bool _userRatingLoaded = false;
  RatingModule userRating;
  List<PriceItem> pricesList;
  List<RatingModule> ratingsBestWorst;

  Future _fetchPrices(String centerID) async {
    if (_pricesLoaded) return;
    var rep =
        await CampingCenterService.getCenterPrices(centerID) as List<PriceItem>;
    setState(() {
      pricesList = rep;
      _pricesLoaded = true;
    });
  }

  Future _fetchRatings(String centerID) async {
    if (_ratingsLoaded) return;

    var rep = await CampingCenterService.getCenterRatingsBM(centerID)
        as List<RatingModule>;
    print("response HHH " + rep.toString());
    setState(() {
      ratingsBestWorst = rep;
      print("rep        " + rep.toString());
      _ratingsLoaded = true;
    });
  }

  Future _fetchingUserRating(String email, String centerMod) async {
    if (_userRatingLoaded) return;
    var rating = await CampingCenterService.getUserRating(centerMod);
    if (rating != null) {
      setState(() {
        userRating = rating;
        _userRatingLoaded = true;
        _alreadyRated = true;
      });
    }
  }

  void refreshUserRating() {
    print("user rating refresh");
    setState(() {
      _ratingsLoaded = false;
      _userRatingLoaded = false;
    });
  }

  String email = '';

  void init() {
    email = LocalStorageService.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    //load center data
    ListItemCenter centerModule =
        ModalRoute.of(context).settings.arguments as ListItemCenter;
    //load prices
    _fetchPrices(centerModule.centerID);
    //load ratings
    _fetchRatings(centerModule.centerID);
    //load user ratings
    _fetchingUserRating(email, centerModule.centerID);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.only(top: screenSize.height * 0.33),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReadMoreText(
                            text: centerModule.description,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TitleText(
                            "Directions :",
                            bottomMargin: 7,
                          ),
                          ClippingStyled(
                            radius: 30,
                            child: MapPreviewWidget.small(
                              latitude: centerModule.coordLat,
                              longitude: centerModule.coordLon,
                              street: centerModule.street,
                              screenSize: screenSize,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.directions,
                                color: CustomColor.interactable,
                              ),
                              label: Text(
                                "Get Directions",
                                style: TextStyle(
                                    color: CustomColor.interactable,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                UrlService.openUrl(
                                    "https://www.google.com/maps/dir/?api=1&destination=${centerModule.coordLat},${centerModule.coordLon}");
                                /*
                                Clipboard.setData(ClipboardData(
                                        text:
                                            "${centerData['coordLog']},${centerData['coordLat']}"))
                                    .then((value) => {
                                          Fluttertoast.showToast(
                                              msg: "Copied to clipboard",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              textColor: CostumColor
                                                  .darkTheme.backgroundColor,
                                              fontSize: 15.0)
                                        });*/
                              },
                            ),
                          ),
                          TitleText(
                            "Prices :",
                            bottomMargin: 7,
                          ),
                          _pricesLoaded
                              ? PriceItemList(
                                  accessPrice: centerModule.accessPrice,
                                  pricesList: pricesList,
                                  screenSize: screenSize)
                              : PriceItemList.loading(
                                  accessPrice: centerModule.accessPrice,
                                  screenSize: screenSize),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            margin: EdgeInsets.symmetric(vertical: 30),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              textColor: CustomColor.highlightText,
                              color: CustomColor.interactable,
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    CenterMakeReservationScreen.routeName,
                                    arguments: {
                                      'priceItems': pricesList,
                                      'acessPrice': centerModule.accessPrice
                                    });
                              },
                              child: Text(
                                "Book now",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          TitleText(
                            "User Reviews:",
                            bottomMargin: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Avrage Score : ${centerModule.avgRating}",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: CustomColor.primaryText),
                              ),
                              SmoothStarRating(
                                allowHalfRating: true,
                                color: CustomColor.secondaryHighlight,
                                borderColor: CustomColor.secondaryHighlight,
                                rating: centerModule.avgRating,
                                isReadOnly: true,
                                size: 30,
                              )
                            ],
                          ),
                          Text(
                            "${centerModule.numbRating} user reviews",
                            style: TextStyle(color: CustomColor.secondaryText),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          _ratingsLoaded
                              ? Container(
                                  child: (ratingsBestWorst != null &&
                                          ratingsBestWorst.length >= 1 &&
                                          ratingsBestWorst[0] != null)
                                      ? RatingWidget(
                                          ratingsBestWorst[0].asBest())
                                      : null)
                              : RatingWidget.loading(
                                  ratingSpecial: RatingSpecial.Best,
                                ),
                          _ratingsLoaded
                              ? Container(
                                  child: (ratingsBestWorst != null &&
                                          ratingsBestWorst.length >= 2 &&
                                          ratingsBestWorst[1] != null)
                                      ? RatingWidget(
                                          ratingsBestWorst[1].asWorst())
                                      : null)
                              : RatingWidget.loading(
                                  ratingSpecial: RatingSpecial.Worst),
                          !_alreadyRated
                              ? Container(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        TitleText(
                                          "Rate this center :",
                                        ),
                                        Text(
                                          "Tell others what you think ",
                                          style: TextStyle(
                                              color: CustomColor.secondaryText),
                                        ),
                                      ],
                                    ),
                                    RatingBottomSheet(
                                      centerID: centerModule.centerID,
                                      refreshScreenCallback: refreshUserRating,
                                    )
                                  ],
                                ))
                              : Container(
                                  child: ModifyRating(
                                  refreshScreenCallback: refreshUserRating,
                                  userRating: userRating.asOwn(),
                                  centerID: centerModule.centerID,
                                ))
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          CampingCenterDetailHeader(
              centerName: centerModule.name,
              imagePath: centerModule.previewPicture,
              city: centerModule.city,
              screenSize: screenSize,
              controller: scrollController,
              role: 2,
              rating: centerModule.avgRating),
        ],
      ),
    );
  }

  @override
  initState() {
    scrollController = ScrollController();
    super.initState();
    init();
  }
}
