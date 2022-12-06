import 'package:Wanderer/Modules/Organization.dart';
import 'package:Wanderer/Services/OrganizationService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Organization/DrawerOrganization.dart';
import 'package:Wanderer/widgets/Shared/CityPicker.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'OrganizationScreen.dart';

class UpdateOrganizationProfile extends StatefulWidget {
  static final String routeName = "/updateOrganizationProfile";

  UpdateOrganizationProfile();
  @override
  _UpdateOrganizationProfileState createState() =>
      _UpdateOrganizationProfileState();
}

class _UpdateOrganizationProfileState extends State<UpdateOrganizationProfile> {
  OrganizationModel profile;
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
                  maximumYear: DateTime.now().year,
                  initialDateTime: DateTime.parse(profile.doc),
                  onDateTimeChanged: (date) => {
                        setState(() {
                          profile.doc = formatter.format(date);
                        })
                      },
                  mode: CupertinoDatePickerMode.date));
        });
  }

  void _getCityValue(String city) {
    setState(() {
      profile.city = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    profile = ModalRoute.of(context).settings.arguments as dynamic;
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
                    'Profile Informations :',
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
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
                      hintText: profile.city,
                      hintStyle: TextStyle(color: Colors.white70)),
                  controller: TextEditingController()..text = profile.city,
                  onTap: () => _showCityPicker(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 30, left: 30),
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
                      labelText: 'Date of creation',
                      labelStyle: TextStyle(color: Colors.white70),
                      hintText: profile.doc,
                      hintStyle: TextStyle(color: Colors.white70)),
                  controller: TextEditingController()
                    ..text = formatter2.format(DateTime.parse(profile.doc)),
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
                        labelText: 'Phone number',
                        labelStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: profile.phone.toString(),
                        selection: TextSelection.collapsed(
                          offset: profile.phone.toString().length,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 11,
                    maxLengthEnforced: true,
                    onChanged: (val) {
                      setState(() {
                        profile.phone = int.parse(val);
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
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white70),
                        hintText: 'Tell us more about your organization',
                        hintStyle: TextStyle(color: Colors.white70)),
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: profile.description,
                        selection: TextSelection.collapsed(
                          offset: profile.description.length,
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
                        profile.description = val;
                      });
                    }),
              ),

              /*Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 30),
                    child: Text(
                      'Seller Informations :',
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    )),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 42),
                  child: Text('How can potential buyers contact you ',
                      style: TextStyle(color: CustomColor.interactableAccent)),
                ),
              ),*/
              Padding(
                padding: EdgeInsets.only(),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  textColor: CustomColor.highlightText,
                  color: CustomColor.interactable,
                  onPressed: () {
                    OrganizationService.updateProfile(profile).then((value) => {
                          if (value.data['status'])
                            {
                              Navigator.pushNamed(
                                  context, OrganizationScreen.routeName,
                                  arguments: {
                                    'flag': 'whatever',
                                    'email': null
                                  })
                            }
                        });
                  },
                  child: Text(
                    "Update",
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
