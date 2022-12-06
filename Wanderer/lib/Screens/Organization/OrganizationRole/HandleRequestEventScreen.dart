import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:Wanderer/widgets/Organization/EventStats.dart';
import 'package:Wanderer/widgets/Organization/HandleReservationEvent.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';

import 'package:flutter/material.dart';

class HandleRequestEventScreen extends StatefulWidget {
  static final String routeName = "/handleEventRequest";

  HandleRequestEventScreen();
  @override
  _HandleRequestEventScreenState createState() =>
      _HandleRequestEventScreenState();
}

class _HandleRequestEventScreenState extends State<HandleRequestEventScreen> {
  bool loading = true;
  String searchKey;
  bool searching = false;
  //var list;

/*
  Future _fetchMyEventsUpcoming(String org) async {
    var rep = await OrganizationService.getMyEventsUpcoming(org)
        as Iterable<OrganizedEvent>;
    setState(() {
      litems = litems..addAll(rep);
      loading = false;
    });
  }

  void initState() {
    super.initState();
    _fetchMyEventsUpcoming(widget.org);
  }
*/
  Future _searchItem(String dearchKey) async {
    /*var result = await MarketPlaceService.search(searchKey)
        as Iterable<MarketPlaceItemModule>;
    setState(() {
      list = result;
      loading = false;
    });*/
  }

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<OrganizedEvent> litems =
        ModalRoute.of(context).settings.arguments as List<OrganizedEvent>;

    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          toolbarHeight: 90,
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
                            setState(() {
                              loading = true;
                              searchKey = val;
                              _searchItem(searchKey);
                            });
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
          child: !searching
              ? Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: litems.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: FlatButton(
                                    onPressed: () => {
                                      Navigator.pushNamed(context,
                                          HandleReservationEvent.routeName,
                                          arguments: litems[index])
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
                                            litems[index].name,
                                            style: TextStyle(
                                                color: CustomColor
                                                    .interactableAccent,
                                                fontSize: 17),
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
                                    height: 150,
                                    child: EventStats(litems[index], false)),
                                Opacity(
                                  opacity: 0.41,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 1,
                                    width: width - 70,
                                    decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }))
              : Container(child: Text(searchKey)),
        ));
  }
}
