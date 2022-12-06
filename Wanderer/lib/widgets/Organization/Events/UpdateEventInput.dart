import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Screens/Organization/OrganizationRole/UpdateEventDetails.dart';

import 'package:Wanderer/Services/EventService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Wanderer/Icons/profile_icons.dart';

class UpdateEventInput extends StatefulWidget {
  OrganizedEvent event;
  String org;
  UpdateEventInput(this.event, this.org);

  @override
  _UpdateEventInputState createState() => _UpdateEventInputState();
}

class _UpdateEventInputState extends State<UpdateEventInput> {
  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      widget.event = OrganizedEvent(
          id: "0000",
          name: "Event name",
          description: "Description",
          price: 0,
          distanceInKm: 0,
          totalPlaces: 0,
          nbParticipants: 0,
          date: DateTime.now(),
          coordLat: 0,
          coordLng: 0,
          startCity: "City",
          picture: "placeholder-image_rectangle",
          street: "Address",
          featured: false,
          orgId: widget.org);
    }
    eventName = new TextEditingController(text: widget.event.name);
    description = new TextEditingController(text: widget.event.description);
    price = new TextEditingController(text: widget.event.price.toString());
    distanceInKm =
        new TextEditingController(text: widget.event.distanceInKm.toString());
    totalPlaces =
        new TextEditingController(text: widget.event.totalPlaces.toString());
    eventStreet = new TextEditingController(text: widget.event.street);
  }

  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter2 = new DateFormat('MM-dd-yyyy');
  DateTime startDate;
  int cityIndex = 0;
  TextEditingController eventName;
  TextEditingController description;
  TextEditingController price;
  TextEditingController distanceInKm;
  TextEditingController totalPlaces;
  TextEditingController eventStreet;

  static List<String> cities = [
    'Ariana',
    'Béja',
    'Ben Arous',
    'Bizerte',
    'Gabès',
    'Gafsa',
    'Jendouba',
    'Kairouan',
    'Kasserine',
    'Kébili',
    'Le Kef	',
    'Mahdia',
    'La Manouba',
    'Médenine',
    'Monastir',
    'Nabeul',
    'Sfax',
    'Sidi Bouzid',
    'Siliana',
    'Sousse',
    'Tataouine',
    'Tozeur',
    'Tunis',
    'Zaghouan',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'General informations:',
              style: TextStyle(
                  color: CustomColor.interactable,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(children: <Widget>[
              Icon(
                Icons.edit,
                color: Colors.white70,
                size: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: TextField(
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 15)),
                    controller: eventName,
                    onChanged: (String name) {
                      setState(() {
                        widget.event.name = name;
                      });
                    },
                  ),
                ),
              )
            ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Profile.location,
                    color: Colors.white70,
                    size: 18,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        _showCityPicker(context);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.event.startCity,
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(34.0, 0, 0, 0),
                  child: TextField(
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelStyle:
                            TextStyle(color: Colors.white70, fontSize: 8)),
                    controller: eventStreet,
                    onChanged: (String street) {
                      setState(() {
                        widget.event.street = street;
                      });
                    },
                  ),
                ),
              )
            ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: Colors.white70,
                    size: 18,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        onPressed: () {
                          _showDatePicker(context);
                        },
                        child: Text(
                          formatter2.format(widget.event.date),
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Icon(
                      Icons.text_fields,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextField(
                        maxLines: 4,
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white70)),
                        controller: description,
                        onChanged: (String desc) {
                          setState(() {
                            widget.event.description = desc;
                          });
                        },
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Detailed informations:',
              style: TextStyle(
                  color: CustomColor.interactable,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Total price: ',
                      style: TextStyle(color: Colors.white70)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white70)),
                        controller: price,
                        onChanged: (String price) {
                          setState(() {
                            widget.event.price = double.parse(price);
                          });
                        },
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hiking distance: ',
                      style: TextStyle(color: Colors.white70)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white70)),
                        controller: distanceInKm,
                        onChanged: (String distance) {
                          setState(() {
                            widget.event.distanceInKm = double.parse(distance);
                          });
                        },
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Available places: ',
                      style: TextStyle(color: Colors.white70)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white70)),
                        controller: totalPlaces,
                        onChanged: (String total) {
                          setState(() {
                            widget.event.totalPlaces = int.parse(total);
                          });
                        },
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: OutlineButton(
              padding: EdgeInsets.fromLTRB(105, 10, 105, 10),
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              borderSide: BorderSide(color: Colors.white70, width: 2),
              child: Text((widget.event.id == "0000") ? "Create" : "Update",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70)),
              onPressed: () {
                //Create
                if (widget.event.id == "0000") {
                  EventService.createOrgEvent(widget.event).then((value) {
                    if (value.data['status']) {
                      OrganizedEvent e =
                          OrganizedEvent.fromJson(value.data['event']);
                      Navigator.pop(context);

                      Navigator.pushNamed(context, UpdateEventDetails.routeName,
                          arguments: e);
                    }
                  });
                }
                //Update
                else {
                  EventService.updateOrgEvent(widget.event).then((value) {
                    if (value.data['status'] == true) {
                      OrganizedEvent e =
                          OrganizedEvent.fromJson(value.data['event']);
                      Navigator.pushNamed(context, UpdateEventDetails.routeName,
                          arguments: e);
                    } else {}
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCityPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(child: cityPicker());
        });
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              child: CupertinoDatePicker(
                  maximumYear: 2025,
                  initialDateTime: widget.event.date,
                  onDateTimeChanged: (date) => {
                        setState(() {
                          this.startDate = date;
                          widget.event.date = date;
                        })
                      },
                  mode: CupertinoDatePickerMode.date));
        });
  }

  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
  Widget cityPicker() => SizedBox(
        height: 300,
        child: CupertinoPicker(
          itemExtent: 64,
          diameterRatio: 0.7,
          looping: true,
          onSelectedItemChanged: (index) =>
              setState(() => widget.event.startCity = cities[index]),
          // selectionOverlay: Container(),
          children: modelBuilder<String>(
            cities,
            (index, value) {
              //final isSelected = this.cityIndex == index;
              //final color = isSelected ? Colors.pink : Colors.black;

              return Center(
                child: Text(
                  value,
                  //style: TextStyle(color: color, fontSize: 24),
                ),
              );
            },
          ),
        ),
      );
}
