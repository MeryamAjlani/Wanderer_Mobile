import 'package:Wanderer/Modules/OrganizedEvent.dart';

import 'package:Wanderer/Services/ReservationEventsService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Shared/LoadingWidget.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats {
  int places = 0;
  int tents = 0;
  int sleepingBags = 0;
  Stats(this.places, this.tents, this.sleepingBags);
  factory Stats.fromJson(dynamic json) {
    return Stats(json["places"], json["tents"], json["sleepingBags"]);
  }
}

class EventStats extends StatefulWidget {
  OrganizedEvent event;
  bool all;
  EventStats(this.event, this.all);
  @override
  _EventStatsState createState() => _EventStatsState();
}

class _EventStatsState extends State<EventStats> {
  bool loading = true;

  Stats pending = Stats(0, 0, 0);
  Stats reserved = Stats(0, 0, 0);
  Stats total = Stats(0, 0, 0);

  @override
  initState() {
    super.initState();
    _fetchStats(widget.event.id);
  }

  _fetchStats(String eventid) async {
    await ReservationEventsService.getEventStats(eventid).then((value) {
      setState(() {
        if (value.data["pending"].length != 0) {
          pending = Stats.fromJson(value.data["pending"][0]);
        }
        if (value.data["reserved"].length != 0) {
          reserved = Stats.fromJson(value.data["reserved"][0]);
        }
        if (value.data["total"].length != 0) {
          total = Stats.fromJson(value.data["total"]);
        }
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<GDPData> _chartDataPlaces = [
      GDPData('paid reservations', reserved.places),
      GDPData('pending reservations', pending.places),
      GDPData('available places',
          total.places - (reserved.places + pending.places)),
    ];
    List<GDPData> _chartDataTents = [
      GDPData('paid reservations', reserved.tents),
      GDPData('pending reservations', pending.tents),
      GDPData(
          'available tents', total.tents - (pending.tents + reserved.tents)),
    ];
    List<GDPData> _chartDataSleepingBags = [
      GDPData('paid reservations', reserved.sleepingBags),
      GDPData('pending reservations', pending.sleepingBags),
      GDPData('available sleeping bags',
          total.sleepingBags - (pending.sleepingBags + reserved.sleepingBags)),
    ];

    return SafeArea(
        child: Scaffold(
            backgroundColor: CustomColor.backgroundColor,
            body: loading
                ? LoadingWidget()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text(
                          'Reservations :',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 130,
                        child: SfCircularChart(
                            margin: EdgeInsets.all(0),
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                textStyle: TextStyle(color: Colors.white)),
                            series: <CircularSeries>[
                              PieSeries<GDPData, String>(
                                  dataSource: _chartDataPlaces,
                                  xValueMapper: (GDPData data, _) =>
                                      data.continent,
                                  yValueMapper: (GDPData data, _) => data.gdp,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ]),
                      ),
                      if (widget.all)
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Tents :',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: width * 0.4,
                                  child: SfCircularChart(
                                      margin: EdgeInsets.all(0),
                                      series: <CircularSeries>[
                                        PieSeries<GDPData, String>(
                                            dataSource: _chartDataTents,
                                            xValueMapper: (GDPData data, _) =>
                                                data.continent,
                                            yValueMapper: (GDPData data, _) =>
                                                data.gdp,
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true))
                                      ]),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Sleeping bags :',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: width * 0.4,
                                  child: SfCircularChart(
                                      margin: EdgeInsets.all(0),
                                      series: <CircularSeries>[
                                        PieSeries<GDPData, String>(
                                            dataSource: _chartDataSleepingBags,
                                            xValueMapper: (GDPData data, _) =>
                                                data.continent,
                                            yValueMapper: (GDPData data, _) =>
                                                data.gdp,
                                            dataLabelSettings:
                                                DataLabelSettings(
                                                    isVisible: true))
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        )
                    ],
                  )));
  }
}

class GDPData {
  final String continent;
  final int gdp;
  GDPData(this.continent, this.gdp);
}
