import 'package:Wanderer/Screens/MarketPlace/AddProduct.dart';
import 'package:Wanderer/Screens/MarketPlace/CategoryList.dart';

import 'package:Wanderer/Services/MarketPlaceService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/widgets/Marketplace/MarketPlace.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/material.dart';

class Catalogue extends StatefulWidget {
  static final String routeName = "/Catalogue";
  @override
  _CatalogueState createState() => _CatalogueState();
}

var categories = [
  'Boots',
  'Jackets',
  'Tents',
  'Sleeping bags',
  'Utensils',
  'Mattresses',
  'Lamps,hamac',
  'chairs&tables',
];

List preview = [];

class _CatalogueState extends State<Catalogue> {
  String searchKey;
  var list;
  bool load = false;
  Future _fetchPreviewPictures() async {
    if (load) return;
    var listP = await MarketPlaceService.getPreview() as List;
    setState(() {
      preview = listP;
      load = true;
    });
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    _fetchPreviewPictures();
    print(preview);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        toolbarHeight: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
          ),
        ),
        titleSpacing: 5.0,
        elevation: 5.0,
        backgroundColor: CustomColor.lightBackground,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 55,
                      margin: EdgeInsets.only(bottom: 55.0),
                      child: TextField(
                        style: TextStyle(color: CustomColor.highlightText),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: CustomColor.highlightText),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: CustomColor.interactableAccent),
                            ),
                            prefixIcon: Icon(Icons.search,
                                color: CustomColor.secondaryText),
                            labelText: 'Search',
                            labelStyle:
                                TextStyle(color: CustomColor.secondaryText)),
                        onSubmitted: (val) {
                          if (val != '')
                            Navigator.pushNamed(context, CategoryList.routeName,
                                arguments: MarketArguments(val, -1));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        /*leading: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: GestureDetector(
              child: Icon(
                Icons.menu,
                color: Color(0xFF3c144d),
                size: 35,
              ),
            ),
          ),*/
      ),
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: RaisedButton.icon(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    color: CustomColor.interactable,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddProduct.routeName);
                    },
                    icon: Icon(
                      Icons.add,
                      color: CustomColor.highlightText,
                    ),
                    label: Text(
                      "Add Product",
                      style: TextStyle(color: CustomColor.highlightText),
                    )),
              ),
              Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctxt, int index1) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: FlatButton(
                                    //navigating to a list showing all product
                                    onPressed: () => {
                                      Navigator.pushNamed(
                                          context, CategoryList.routeName,
                                          arguments:
                                              MarketArguments(null, index1))
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0, left: 25),
                                          child: Text(
                                            categories[index1],
                                            style: TextStyle(
                                                color: CustomColor
                                                    .interactableAccent,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0.0, bottom: 10),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0),
                                                child: Text('See more',
                                                    style: TextStyle(
                                                        color: CustomColor
                                                            .interactable)),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: CustomColor.interactable,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width - 50,
                                  height: 100,
                                  child: load
                                      ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          itemCount: 5,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  height: 20,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(6)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            ImageService.imageUrl(
                                                                preview[index1]
                                                                        .previewPicture[
                                                                    index])),
                                                        fit: BoxFit.fill),
                                                  )),
                                            );
                                          })
                                      : LoadingWidget(),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          )),
    );
  }
}
