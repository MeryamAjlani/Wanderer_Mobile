import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Modules/ReservationEventModule.dart';

import 'package:Wanderer/Services/ReservationEventsService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Organization/DrawerOrganization.dart';

import 'package:Wanderer/widgets/Organization/NotFoundEvents.dart';
import 'package:Wanderer/widgets/Organization/Reservation.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class MyReservations extends StatefulWidget {
  static final String routeName = "/MyReservations";

  @override
  _MyReservationsState createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  bool loading = true;

  List<ReservationEvent> litems = [];

  void initState() {
    super.initState();
  }

  void _refresh() {
    setState(() {
      loading = true;
      litems = [];
    });
  }

  Future _fetchReservationsByEvent() async {
    if (!loading) {
      return;
    }
    var rep = await ReservationEventsService.getMyReservations()
        as Iterable<ReservationEvent>;

    setState(() {
      litems = litems..addAll(rep);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    var width = MediaQuery.of(context).size.width;

    final event = ModalRoute.of(context).settings.arguments as OrganizedEvent;

    _fetchReservationsByEvent();

    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        drawer: DrawerOrganizationWidget(),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        minWidth: double.infinity),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Column(
                            children: [
                              Text(
                                'My reservations',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: CustomColor.interactable),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(15, 7, 15, 20),
                                  height: 3,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: CustomColor.interactable,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            loading
                                ? LoadingWidget()
                                : (litems.length == 0)
                                    ? NotFoundEvents(
                                        org: event.name,
                                        message: 'reservations')
                                    : Container(
                                        child: ListView.builder(
                                            controller: _scrollController,
                                            shrinkWrap: true,
                                            itemCount: litems.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) {
                                              return Reservation(
                                                  litems[index], _refresh);
                                            }),
                                      )
                          ],
                        ),
                      ],
                    )))));
  }
}
