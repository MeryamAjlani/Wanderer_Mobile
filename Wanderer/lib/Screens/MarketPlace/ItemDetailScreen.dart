import 'package:Wanderer/Modules/MarketPlaceItemModule.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Shared/Carousel.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ItemDetailScreen extends StatefulWidget {
  static final String routeName = "/itemDetail";
  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    MarketPlaceItemModule itemModule =
        ModalRoute.of(context).settings.arguments as MarketPlaceItemModule;

    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: CustomColor.backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SafeArea(
                  child: Container(
                height: size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(itemModule.previewPicture),
                        fit: BoxFit.cover)),
              )),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColor.backgroundColor,
                    ),
                    child: FlatButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: CustomColor.interactable,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.35),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12, bottom: 20),
                              child: SizedBox(
                                width: 350,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.attach_money,
                                        color: Colors.white,
                                      ),
                                    ),
                                    AutoSizeText(itemModule.price + " DT ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              child: AutoSizeText(
                                itemModule.name,
                                style: TextStyle(
                                    color: CustomColor.interactable,
                                    fontSize: 25),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SizedBox(
                                width: 350,
                                child: AutoSizeText(itemModule.brand,
                                    style: TextStyle(
                                        color: CustomColor.interactableAccent,
                                        fontSize: 20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: AutoSizeText(
                                "Available in :",
                                style: TextStyle(
                                    color: CustomColor.interactable,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SizedBox(
                                width: 350,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 0.0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                    ),
                                    AutoSizeText(itemModule.city,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: SizedBox(
                                width: 350,
                                child: AutoSizeText(
                                  "Description :",
                                  style: TextStyle(
                                      color: CustomColor.interactable,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: SizedBox(
                                  width: 360,
                                  child: AutoSizeText(
                                    itemModule.description,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 45.0, bottom: 5),
                              child: SizedBox(
                                width: 350,
                                child: AutoSizeText(
                                  "See more pictures :",
                                  style: TextStyle(
                                      color: CustomColor.interactable,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              child: Carousel(
                                rawPictures: [
                                  "piihyaam2w8q8avn3gf1",
                                  "piihyaam2w8q8avn3gf1",
                                  "piihyaam2w8q8avn3gf1"
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              margin: EdgeInsets.only(top: 60),
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                textColor: CustomColor.highlightText,
                                color: CustomColor.interactable,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!

                                    builder: (BuildContext context) {
                                      return new AlertDialog(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        backgroundColor:
                                            CustomColor.lightBackground,
                                        title: Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  itemModule.userImage,
                                                ),
                                              ),
                                            )),
                                        content: Container(
                                          width: 250,
                                          height: 66,
                                          child: new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: new Text(
                                                  itemModule.userName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 14.0,
                                                            top: 4),
                                                    child: Icon(
                                                      Icons.phone_android,
                                                      color: CustomColor
                                                          .interactableAccent,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 14.0),
                                                    child: Text(
                                                        //itemModule.userNumber,
                                                        "555555",
                                                        style: TextStyle(
                                                            color: CustomColor
                                                                .interactableAccent,
                                                            fontSize: 20)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          new FlatButton(
                                            child: Container(
                                                height: 20,
                                                child: new Text(
                                                  'Close',
                                                  style: TextStyle(
                                                      color: CustomColor
                                                          .interactable),
                                                )),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  " Contact information",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
