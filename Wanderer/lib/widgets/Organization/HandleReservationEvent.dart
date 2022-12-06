import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Modules/ReservationEventModule.dart';

import 'package:Wanderer/Services/ReservationEventsService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:Wanderer/widgets/Organization/EventStats.dart';
import 'package:Wanderer/widgets/Organization/NotFoundEvents.dart';
import 'package:Wanderer/widgets/Organization/ReservationAccept.dart';
import 'package:Wanderer/widgets/Organization/ParticipantAccept.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class HandleReservationEvent extends StatefulWidget {
  static final String routeName = "/handleEventReservation";

  @override
  _HandleReservationEventState createState() => _HandleReservationEventState();
}

class _HandleReservationEventState extends State<HandleReservationEvent> {
  bool loading = true;

  List<ReservationEvent> litems = [];
  List<ReservationEvent> litemsP = [];

  void initState() {
    super.initState();
  }

  void _refresh() {
    setState(() {
      loading = true;

      litems = [];
      litemsP = [];
    });
  }

  Future _fetchReservationsByEvent(String eventid) async {
    if (!loading) {
      return;
    }
    var rep = await ReservationEventsService.getMyEventReservations(eventid)
        as Iterable<ReservationEvent>;

    var rep2 = await ReservationEventsService.getMyEventParticipants(eventid)
        as Iterable<ReservationEvent>;
    setState(() {
      litems = litems..addAll(rep);
      litemsP = litemsP..addAll(rep2);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    var width = MediaQuery.of(context).size.width;

    final event = ModalRoute.of(context).settings.arguments as OrganizedEvent;

    _fetchReservationsByEvent(event.id);

    return Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        drawer: DrawerWidget(),
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
                                event.name,
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
                        SizedBox(
                            width: width - 50,
                            height: 320,
                            child: EventStats(event, true)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                'Reservations list: ',
                                style: TextStyle(
                                    fontSize: 21,
                                    color: CustomColor.interactable),
                              ),
                            ),
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
                                              return ReservationAccept(
                                                  litems[index], _refresh);
                                            }),
                                      )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                'Participants list: ',
                                style: TextStyle(
                                    fontSize: 21,
                                    color: CustomColor.interactable),
                              ),
                            ),
                            loading
                                ? LoadingWidget()
                                : (litemsP.length == 0)
                                    ? NotFoundEvents(
                                        org: event.name,
                                        message: 'participants')
                                    : Container(
                                        child: ListView.builder(
                                            controller: _scrollController,
                                            shrinkWrap: true,
                                            itemCount: litemsP.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) {
                                              return ParticipantAccept(
                                                  litemsP[index], _refresh);
                                            }),
                                      )
                          ],
                        ),
                      ],
                    )))));
  }
}
