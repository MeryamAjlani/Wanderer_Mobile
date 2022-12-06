import 'dart:io';
import 'dart:ui';
import 'package:Wanderer/Services/AuthService.dart';
import 'package:Wanderer/Modules/EditPriceItem.dart';
import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Screens/AuthWelcomeScreen.dart';

import 'package:Wanderer/Modules/RatingModule.dart';
import 'package:Wanderer/Services/CampingCenterService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/LocalStorageService.dart';
import 'package:Wanderer/Services/Utility/UrlService.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterEditable/CampingCenterEditorHeader.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterEditable/UpdateCenterInput.dart';
import 'package:Wanderer/widgets/CampingCenter/DrawerCenter.dart';
import 'package:Wanderer/widgets/CampingCenter/MapPreviewWidget.dart';
import 'package:Wanderer/widgets/CampingCenter/PriceItemList.dart';
import 'package:Wanderer/widgets/CampingCenter/RatingWidget.dart';
import 'package:Wanderer/widgets/CampingCenter/ReadMoreText.dart';
import 'package:Wanderer/widgets/CampingCenter/TitleText.dart';
import 'package:Wanderer/widgets/Shared/ClippingStyled.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:Wanderer/Modules/ListItemCenter.dart';

import 'CenterPriceEditScreen.dart';

class CampingCenterProfileScreen extends StatefulWidget {
  static final String routeName = "/profile/center";
  @override
  _CampingCenterProfileScreenState createState() =>
      _CampingCenterProfileScreenState();
}

class _CampingCenterProfileScreenState
    extends State<CampingCenterProfileScreen> {
  List<EditPriceItem> editPriceItems = List<EditPriceItem>();
  EditPriceItem editAcessPrice;
  ScrollController scrollController;
  bool _pricesLoaded = false;
  bool _isEditPrices = false;
  bool _ratingsLoaded = false;
  bool _centerLoaded = false;
  RatingModule userRating;
  List<PriceItem> pricesList;
  List<RatingModule> ratingsBestWorst;
  ListItemCenter center;

  File croppedImage;

  Future _fetchPrices(String centerID) async {
    if (_pricesLoaded) return;
    var rep =
        await CampingCenterService.getCenterPrices(centerID) as List<PriceItem>;
    setState(() {
      pricesList = rep;
      _pricesLoaded = true;
    });
    initEditedPrices();
  }

  void refreshPricesList(double newAccessPrice) {
    setState(() {
      center.accessPrice = newAccessPrice;
      _isEditPrices = false;
      _pricesLoaded = false;
      pricesList = List<PriceItem>();
    });
  }

  void initEditedPrices() {
    editPriceItems = List<EditPriceItem>();
    editPriceItems.add(EditPriceItem(
        priceItem: PriceItem(
          price: center.accessPrice,
        ),
        isAccess: true));
    for (var priceItem in pricesList) {
      editPriceItems.add(EditPriceItem(priceItem: priceItem));
    }
  }

  void cancelEditedPrices() {
    setState(() {
      _isEditPrices = false;
    });
    initEditedPrices();
  }

  Future _fetchRatings(String centerID) async {
    if (_ratingsLoaded) return;

    var rep = await CampingCenterService.getCenterRatingsBM(centerID)
        as List<RatingModule>;
    setState(() {
      ratingsBestWorst = rep;
      _ratingsLoaded = true;
    });
  }

  Future<void> showUpdateDialog(BuildContext contexte) async {
    return await showDialog(
        context: contexte,
        builder: (context) {
          return AlertDialog(
            backgroundColor: CustomColor.backgroundColor,
            content: UpdateCenterInput(center),
          );
        }).then((_) async {
      setState(() async {
        center = await CampingCenterService.getOwnedCenter();
      });
    });
  }

  Future _fetchCenter() async {
    if (_centerLoaded) return;
    CampingCenterService.getOwnedCenter().then((value) {
      setState(() {
        _centerLoaded = true;
        center = value;
      });
    });
  }

  void refreshUserRating() {
    print("user rating refresh");
    setState(() {
      _ratingsLoaded = false;
    });
  }

  void refreshCenterPicture(String image) {
    setState(() {
      center = center.changePicture(image);
    });
  }

  String email = '';

  void init() {
    email = LocalStorageService.getString('email');
  }

  @override
  Widget build(BuildContext context) {
    //load center data
    _fetchCenter();
    if (_centerLoaded) {
      //load prices
      _fetchPrices(center.centerID);
      //load ratings
      _fetchRatings(center.centerID);
    }
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerCenterWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: _centerLoaded
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    padding: EdgeInsets.only(top: screenSize.height * 0.33),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleText("Description"),
                                ReadMoreText(
                                  text: center.description,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton.icon(
                                    icon: Icon(
                                      Icons.edit,
                                      color: CustomColor.interactable,
                                    ),
                                    label: Text(
                                      "Update Information",
                                      style: TextStyle(
                                          color: CustomColor.interactable,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      showUpdateDialog(context);
                                    },
                                  ),
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
                                  child: MapPreviewWidget(
                                    latitude: center.coordLat,
                                    longitude: center.coordLon,
                                    street: center.street,
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
                                          "https://www.google.com/maps/dir/?api=1&destination=${center.coordLat},${center.coordLon}");
                                    },
                                  ),
                                ),
                                TitleText(
                                  "Prices :",
                                  bottomMargin: 7,
                                ),
                                /*_isEditPrices
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            bottom: 20, top: 10),
                                        child: PriceItemEditList(
                                          refreshPricesCallback:
                                              refreshPricesList,
                                          centerID: center.centerID,
                                          pricesList: editPriceItems,
                                          screenSize: screenSize,
                                          cancelChangesCallback:
                                              cancelEditedPrices,
                                        ))
                                    : */
                                Column(
                                  children: [
                                    _pricesLoaded
                                        ? PriceItemList(
                                            withStock: true,
                                            accessPrice: center.accessPrice,
                                            pricesList: pricesList,
                                            screenSize: screenSize)
                                        : PriceItemList.loading(
                                            accessPrice: center.accessPrice,
                                            screenSize: screenSize),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        icon: Icon(
                                          Icons.edit,
                                          color: CustomColor.interactable,
                                        ),
                                        label: Text(
                                          "Edit Prices",
                                          style: TextStyle(
                                              color: CustomColor.interactable,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        onPressed: () {
                                          initEditedPrices();
                                          Navigator.of(context).pushNamed(
                                              CenterPriceEditScreen.routeName,
                                              arguments: {
                                                'refreshPricesCallback':
                                                    refreshPricesList,
                                                'centerID': center.centerID,
                                                'pricesList': editPriceItems
                                              });
                                          //_isEditPrices = true;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TitleText(
                                  "User Reviews:",
                                  bottomMargin: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Avrage Score : ${center.avgRating}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: CustomColor.primaryText),
                                    ),
                                    SmoothStarRating(
                                      allowHalfRating: true,
                                      color: CustomColor.secondaryHighlight,
                                      borderColor:
                                          CustomColor.secondaryHighlight,
                                      rating: center.avgRating,
                                      isReadOnly: true,
                                      size: 30,
                                    )
                                  ],
                                ),
                                Text(
                                  "${center.numbRating} user reviews",
                                  style: TextStyle(
                                      color: CustomColor.secondaryText),
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
                                ListTile(
                                  leading: Icon(
                                    Icons.exit_to_app,
                                    color: CustomColor.secondaryText,
                                  ),
                                  title: Text('Logout',
                                      style: TextStyle(
                                          color: CustomColor.secondaryText,
                                          fontSize: 18)),
                                  onTap: () {
                                    AuthService.logout().then((_) {
                                      Navigator.of(context).pushNamed(
                                          AuthWelcomeScreen.routeName);
                                      LocalStorageService.clear();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
                CampingCenterEditorHeader(
                    refreshCenterDataCallback: refreshCenterPicture,
                    centerName: center.name,
                    imagePath: center.previewPicture,
                    city: center.city,
                    screenSize: screenSize,
                    controller: scrollController,
                    role: 2,
                    rating: center.avgRating),
              ],
            )
          : LoadingWidget(),
    );
  }

  @override
  initState() {
    scrollController = ScrollController();
    super.initState();
    init();
  }
}
