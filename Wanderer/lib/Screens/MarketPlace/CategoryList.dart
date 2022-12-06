import 'package:Wanderer/Modules/MarketPlaceItemModule.dart';

import 'package:Wanderer/Screens/MarketPlace/ItemDetailScreen.dart';

import 'package:Wanderer/Services/MarketPlaceService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:Wanderer/widgets/Marketplace/MarketPlace.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';
import 'package:Wanderer/widgets/Shared/NotFound.dart';

import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  static final String routeName = "/Category";

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  bool load = false;
  int categoryIndex = -1;
  String searchKey;
  bool searching = false;
  bool found = false;
  ScrollController _scrollController = new ScrollController();
  List<MarketPlaceItemModule> list = [];
  bool loading = true;
  Future _fetchCategory(int p) async {
    if (load) return;
    var rep =
        await MarketPlaceService.getList(p) as Iterable<MarketPlaceItemModule>;
    setState(() {
      found = true;
      list = rep;
      loading = false;
      load = true;
    });
  }

  Future _searchKey(String key) async {
    if (searching) return;
    var rep =
        await MarketPlaceService.search(key) as Iterable<MarketPlaceItemModule>;
    setState(() {
      if (rep != []) {
        found = true;
      } else {
        found = false;
      }
      list = rep;
      loading = false;
      load = true;
      searching = true;
    });
  }

  void initState() {
    super.initState();
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (searchKey == '') {
          _fetchListSort(page, filterKey);
        } else {
          _fetchListSearch(page, filterKey, searchKey);
        }
      }
    });*/
  }

  Future _fetchingResult(MarketArguments arguments) {
    setState(() {
      searchKey = arguments.searchKey;
      categoryIndex = arguments.index;
    });
    if (searchKey != null)
      _searchKey(searchKey);
    else if (categoryIndex != -1) _fetchCategory(categoryIndex);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var arguments =
        ModalRoute.of(context).settings.arguments as MarketArguments;
    _fetchingResult(arguments);
    return Scaffold(
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
                            if (val != '')
                              Navigator.pushNamed(
                                  context, CategoryList.routeName,
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
        drawer: DrawerWidget(),
        backgroundColor: CustomColor.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Stack(
            children: [
              loading
                  ? LoadingWidget()
                  :
                  //in case the user searched and didn t find anything
                  !found
                      ? NotFound(searchKey: searchKey)
                      : GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 3,
                          children: List.generate(
                            list.length,
                            (index) {
                              return Center(
                                child: Container(
                                  width: (width / 2) - 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ItemDetailScreen.routeName,
                                          arguments: list[index]);
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              9 /
                                              17,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              ImageService.imageUrl(
                                                  list[index].previewPicture)),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(0),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: <Color>[
                                                  Colors.black,
                                                  Colors.black45,
                                                  Colors.black.withAlpha(1),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: new EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(list[index].name,
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                      color: CustomColor
                                                          .highlightText,
                                                      fontSize: 16,
                                                    )),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                              Icons
                                                                  .attach_money,
                                                              size: 20,
                                                              color: CustomColor
                                                                  .interactableAccent
                                                                  .withAlpha(
                                                                      220)),
                                                          Text(
                                                            list[index].price,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: CustomColor
                                                                    .interactableAccent
                                                                    .withAlpha(
                                                                        220)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                /*RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: Icon(Icons.location_pin,
                                          color: Color(0xffe7accf)),
                                  ),
                                ),
                                TextSpan(text: _item.city),
                              ],
                            ),
                          )*/
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
            ],
          ),
        ));
  }
}
