import 'dart:ui';

import 'package:Wanderer/Modules/ListItemCenter.dart';
import 'package:Wanderer/Services/CampingCenterService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/LocationService.dart';
import 'package:Wanderer/widgets/CampingCenter/CenterItemWidget.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';
import 'package:Wanderer/widgets/Shared/NotFound.dart';

import 'package:flutter/material.dart';

import 'package:location/location.dart';

class ListCenters extends StatefulWidget {
  static final String routeName = "/centerList";
  @override
  _ListCentersState createState() => _ListCentersState();
}

class _ListCentersState extends State<ListCenters> {
  List<ListItemCenter> litems = [];
  var searchKey = '';
  int filterKey = 0;
  bool loading = true;
  List<bool> isSelected = [false, false, false, false];
  int page = 1;
  ScrollController _scrollController = new ScrollController();
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _fetchListSort(1, 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (searchKey == '') {
          _fetchListSort(page, filterKey);
        } else {
          _fetchListSearch(page, filterKey, searchKey);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _fetchListSort(int p, int filterKey) async {
    var rep =
        await CampingCenterService.getListSort(p, filterKey, _locationData)
            as Iterable<ListItemCenter>;
    setState(() {
      litems = litems..addAll(rep);
      page = p + 1;
      loading = false;
    });
  }

  Future _fetchListSearch(int p, int filterKey, String searchKey) async {
    var rep = await CampingCenterService.getListSearch(
        p, filterKey, searchKey, _locationData) as Iterable<ListItemCenter>;
    setState(() {
      litems = litems..addAll(rep);
      page = p + 1;
      loading = false;
    });
  }

  void filter() async {
    setState(() {
      page = 1;
      litems = [];
    });
    if (filterKey == 1) {
      setState(() {
        loading = true;
      });
      LocationData loc = await LocationService.getLocation();
      setState(() {
        _locationData = loc;
      });
      print(_locationData);
    }
    if (searchKey == '') {
      _fetchListSort(1, filterKey);
    } else {
      _fetchListSearch(1, filterKey, searchKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: CustomColor.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 140,
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
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: const EdgeInsets.only(top: 0),
                        child: TextField(
                          style: TextStyle(color: CustomColor.highlightText),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColor.highlightText),
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
                            setState(() {
                              loading = true;
                              page = 1;
                              litems = [];
                              searchKey = val;
                            });
                            _fetchListSearch(1, filterKey, searchKey);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0),
                    margin: EdgeInsets.only(left: 20, top: 15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 35,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ToggleButtons(
                                selectedColor: CustomColor.interactable,
                                renderBorder: false,
                                selectedBorderColor:
                                    CustomColor.backgroundColor,
                                fillColor: Colors.transparent,
                                color: CustomColor.highlightText,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      " Closest",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      " Best Rated",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      " Lowest Price ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      " Highest Price ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                                onPressed: (int index) {
                                  setState(
                                    () {
                                      for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] =
                                              !isSelected[buttonIndex];
                                          if (isSelected[buttonIndex]) {
                                            filterKey = index + 1;
                                          } else {
                                            filterKey = 0;
                                          }
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    },
                                  );
                                  filter();
                                },
                                isSelected: isSelected,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
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
        body: loading
            ? LoadingWidget()
            : (litems.length == 0)
                ? NotFound(searchKey: searchKey)
                : new ListView.builder(
                    controller: _scrollController,
                    itemCount: litems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return CenterItemWidget(
                        item: litems[index],
                      );
                    }));
  }
}
