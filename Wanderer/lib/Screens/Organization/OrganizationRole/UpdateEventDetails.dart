import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/UrlService.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterEditable/CampingCenterEditorHeader.dart';
import 'package:Wanderer/widgets/CampingCenter/MapPreviewWidget.dart';
import 'package:Wanderer/widgets/CampingCenter/ReadMoreText.dart';
import 'package:Wanderer/widgets/CampingCenter/TitleText.dart';
import 'package:Wanderer/widgets/Organization/DrawerOrganization.dart';
import 'package:Wanderer/widgets/Shared/ClippingStyled.dart';

import 'package:flutter/material.dart';

import 'UpdateEvent.dart';

class UpdateEventDetails extends StatefulWidget {
  static const routeName = "/orgEventUpdate";
  @override
  _UpdateEventDetailsState createState() => _UpdateEventDetailsState();
}

class _UpdateEventDetailsState extends State<UpdateEventDetails> {
  ScrollController scrollController;
  OrganizedEvent eventModule;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  void refreshPicture(String img) {
    setState(() {
      eventModule.updatePreviewPicture(img);
    });
  }

  Widget build(BuildContext context) {
    eventModule = ModalRoute.of(context).settings.arguments as OrganizedEvent;

    //load prices
    //_fetchPrices(eventModule.centerID);
    //load ratings
    //_fetchRatings(eventModule.centerID);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerOrganizationWidget(),
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
                      padding: EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 38,
                        child: FlatButton(
                            shape: CircleBorder(),
                            color: CustomColor.backgroundColor,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, UpdateEvent.routeName,
                                  arguments: eventModule);
                            },
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: CustomColor.interactable,
                            )),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText("Description :"),
                          ReadMoreText(
                            text: eventModule.description,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TitleText(
                            "Directions :",
                            bottomMargin: 7,
                          ),
                          ClippingStyled(
                            radius: 30,
                            child: MapPreviewWidget.small(
                              latitude: eventModule.startLocation.latitude,
                              longitude: eventModule.startLocation.longitude,
                              street: eventModule.street,
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
                                UrlService.getDirection(
                                    eventModule.startLocation);
                              },
                            ),
                          ),
                          TitleText(
                            "Prices :",
                            bottomMargin: 7,
                          ),
                          /* PriceItemList(
                              accessPrice: eventModule.price,
                              customLabel: 'Booking :',
                              customDiscription:
                                  'booking price per participant',
                              pricesList: [],
                              screenSize: screenSize),*/
                          /* SizedBox(
                            height: 20,
                          ),
                          TitleText(
                            "Event information :",
                            bottomMargin: 7,
                          ),
                          ClippingStyled(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: CustomColor.lightBackground),
                                child: Column(
                                  children: [
                                    PriceItemWidget(
                                      PriceItem(
                                          currency: "Km",
                                          price: eventModule.distanceInKm,
                                          label: "Distance",
                                          description:
                                              "planned travel distance"),
                                      screenSize: screenSize,
                                      isLastItem: false,
                                    ),
                                    PriceItemWidget(
                                      PriceItem(
                                          currency:
                                              "/${eventModule.totalPlaces}",
                                          price:
                                              eventModule.availablePlaces + 0.0,
                                          label: "Available Places",
                                          description:
                                              "the number of remaining places"),
                                      screenSize: screenSize,
                                      isLastItem: true,
                                    ),
                                  ],
                                ),
                              ),
                              radius: 30),*/
                          /*Container(
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
                              onPressed: () {},
                              child: Text(
                                "Book now",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
          CampingCenterEditorHeader(
            refreshCenterDataCallback: refreshPicture,
            centerName: eventModule.name,
            imagePath: eventModule.previewPicture,
            city: eventModule.startCity,
            screenSize: screenSize,
            controller: scrollController,
            role: 1,
            id: eventModule.id,
            date: eventModule.date,
          ),
        ],
      ),
    );
  }
}
