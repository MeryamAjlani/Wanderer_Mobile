import 'package:Wanderer/Screens/User/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Wanderer/Services/ProfileService.dart';
import 'package:Wanderer/Icons/profile_icons.dart';
import 'package:Wanderer/Modules/Profile.dart';

class UpdateProfileWidget extends StatefulWidget {
  final ProfileModel profile;

  UpdateProfileWidget(this.profile);

  @override
  _UpdateProfileWidgetState createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter2 = new DateFormat('MM-dd-yyyy');
  DateTime dateOfBirth;
  int genderIndex = 0;
  int cityIndex = 0;

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 140,
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
                    child: Text(
                      widget.profile.city,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ]),
        ),
        Container(
          width: 140,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Profile.transgender_alt,
                  color: Colors.white70,
                  size: 18,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      _showGenderPicker(context);
                    },
                    child: Text(
                      widget.profile.gender,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ]),
        ),
        Container(
          width: 140,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Profile.birthday,
                  color: Colors.white70,
                  size: 18,
                ),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    onPressed: () {
                      _showDatePicker(context);
                    },
                    child: Text(
                      formatter2.format(DateTime.parse(widget.profile.dob)),
                      style: TextStyle(color: Colors.white70),
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
            child: Text('Update',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white70)),
            onPressed: () {
              ProfileService.updateProfile(widget.profile)
                  .then((value) => {
                        Navigator.of(context).pushNamed(ProfileScreen.routeName,
                            arguments: {'flag': 'whatever', 'email': null})
                      })
                  .catchError((error) => print(error));
            },
          ),
        ),
      ],
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
                  maximumYear: DateTime.now().year,
                  initialDateTime: DateTime.parse(widget.profile.dob),
                  onDateTimeChanged: (date) => {
                        setState(() {
                          this.dateOfBirth = date;
                          widget.profile.dob = formatter.format(date);
                        })
                      },
                  mode: CupertinoDatePickerMode.date));
        });
  }

  void _showGenderPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 50,
              onSelectedItemChanged: (int i) {
                String g;
                if (i == 0) {
                  g = 'Male';
                } else if (i == 1) {
                  g = 'Female';
                } else {
                  g = 'Other';
                }
                setState(() {
                  genderIndex = i;
                  widget.profile.gender = g;
                });
              },
              children: <Widget>[
                Center(
                  child: Text(
                    "Male",
                  ),
                ),
                Center(
                  child: Text(
                    "Female",
                  ),
                ),
                Center(
                  child: Text(
                    "Other",
                  ),
                ),
              ],
            ),
          );
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
              setState(() => widget.profile.city = cities[index]),
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
