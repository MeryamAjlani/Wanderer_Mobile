import 'package:Wanderer/Modules/Organization.dart';
import 'package:Wanderer/Modules/OrganizedEvent.dart';

import 'package:Wanderer/Services/EventService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Organization/DrawerOrganization.dart';
import 'package:Wanderer/widgets/Shared/CityPicker.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'UpdateEventDetails.dart';

class UpdateEvent extends StatefulWidget {
  static final String routeName = "/updateEvent";

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  OrganizationModel profile;
  OrganizedEvent event;
  TextEditingController description;
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter2 = new DateFormat('MM-dd-yyyy');

  void _showCityPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CityPicker(_getCityValue);
        });
  }

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              child: CupertinoDatePicker(
                  minimumDate: DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day),
                  maximumYear: DateTime.now().year + 1,
                  initialDateTime: event.date,
                  onDateTimeChanged: (date) => {
                        setState(() {
                          event.date = date;
                        })
                      },
                  mode: CupertinoDatePickerMode.date));
        });
  }

  void _getCityValue(String city) {
    setState(() {
      event.startCity = city;
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments as OrganizedEvent;
    return Scaffold(
      drawer: DrawerOrganizationWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: Container(
        child: SingleChildScrollView(
            child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 36.0, top: 28),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Event Informations :',
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
                child: TextField(
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: CustomColor.interactable),
                      ),
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white70),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white70),
                    ),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: event.name,
                        selection: TextSelection.collapsed(
                          offset: event.name.length,
                        ),
                      ),
                    ),
                    maxLength: 35,
                    maxLengthEnforced: true,
                    maxLines: 2,
                    minLines: 1,
                    buildCounter: (_, {currentLength, maxLength, isFocused}) =>
                        Container(
                            child: Text(
                          currentLength.toString() + "/" + maxLength.toString(),
                          style: TextStyle(color: Colors.white70),
                        )),
                    onChanged: (val) {
                      setState(() {
                        event.name = val;
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                child: TextField(
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: CustomColor.interactable),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white70),
                        ),
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white70),
                        hintText: 'Tell us more about this event',
                        hintStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: event.description,
                        selection: TextSelection.collapsed(
                          offset: event.description.length,
                        ),
                      ),
                    ),
                    maxLength: 350,
                    maxLengthEnforced: true,
                    maxLines: 8,
                    minLines: 1,
                    buildCounter: (_, {currentLength, maxLength, isFocused}) =>
                        Container(
                            child: Text(
                          currentLength.toString() + "/" + maxLength.toString(),
                          style: TextStyle(color: Colors.white70),
                        )),
                    onChanged: (val) {
                      setState(() {
                        event.description = val;
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                child: TextField(
                  readOnly: true,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: CustomColor.interactable),
                    ),
                    border: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white70),
                    ),
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  controller: TextEditingController()
                    ..text = formatter2.format(event.date),
                  onTap: () => _showDatePicker(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
                child: TextField(
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: CustomColor.interactable),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white70),
                        ),
                        labelText: 'Number of days',
                        labelStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: event.numbdays.toString(),
                        selection: TextSelection.collapsed(
                          offset: event.numbdays.toString().length,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 3,
                    maxLengthEnforced: true,
                    onChanged: (val) {
                      setState(() {
                        event.numbdays = int.parse(val);
                        print(event.numbdays);
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                child: TextField(
                  readOnly: true,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: CustomColor.interactable),
                      ),
                      border: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white70),
                      ),
                      labelText: 'City',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: event.startCity,
                      hintStyle: TextStyle(color: Colors.white70)),
                  controller: TextEditingController()..text = event.startCity,
                  onTap: () => _showCityPicker(context),
                ),
              ),
              //location gps
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
                child: TextField(
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: CustomColor.interactable),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white70),
                        ),
                        labelText: 'Hiking distance (Km)',
                        labelStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: event.distanceInKm.toString(),
                        selection: TextSelection.collapsed(
                          offset: event.distanceInKm.toString().length,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    onChanged: (val) {
                      setState(() {
                        event.distanceInKm = double.parse(val);
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
                child: TextField(
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: CustomColor.interactable),
                        ),
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white70),
                        ),
                        labelText: 'Total places',
                        labelStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: event.totalPlaces.toString(),
                        selection: TextSelection.collapsed(
                          offset: event.totalPlaces.toString().length,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 3,
                    maxLengthEnforced: true,
                    onChanged: (val) {
                      setState(() {
                        event.totalPlaces = int.parse(val);
                      });
                    }),
              ),

              Padding(
                padding: EdgeInsets.only(),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  textColor: CustomColor.highlightText,
                  color: CustomColor.interactable,
                  onPressed: () {
                    OrganizedEvent e;
                    if (event.id == '') {
                      //create new event
                      EventService.createOrgEvent(event).then((value) {
                        if (value.data['status']) {
                          e = OrganizedEvent.fromJson(value.data['event']);
                          Navigator.pop(context);

                          Navigator.pushNamed(
                              context, UpdateEventDetails.routeName,
                              arguments: e);
                        } else {
                          print('error creating');
                        }
                        ;
                      });
                    } else {
                      //update event
                      EventService.updateOrgEvent(event).then((value) {
                        if (value.data['status']) {
                          e = OrganizedEvent.fromJson(value.data['event']);
                          Navigator.pop(context);

                          Navigator.pushNamed(
                              context, UpdateEventDetails.routeName,
                              arguments: e);
                        } else {
                          print('error updating');
                        }
                        ;
                      });
                    }
                  },
                  child: Text(
                    (event.id == '') ? 'Create' : 'Update',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
