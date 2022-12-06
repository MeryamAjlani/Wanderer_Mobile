import 'package:Wanderer/Modules/ListItemCenter.dart';
import 'package:Wanderer/Services/CampingCenterService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Wanderer/Icons/profile_icons.dart';

class UpdateCenterInput extends StatefulWidget {
  final ListItemCenter center;
  UpdateCenterInput(this.center);

  @override
  _UpdateCenterInputState createState() => _UpdateCenterInputState();
}

class _UpdateCenterInputState extends State<UpdateCenterInput> {
  @override
  void initState() {
    super.initState();
    centerName = new TextEditingController(text: widget.center.name);
    description = new TextEditingController(text: widget.center.description);
    centerStreet = new TextEditingController(text: widget.center.street);
    cityIndex = 0;
    for (int i = 0; i < cities.length; i++) {
      if (widget.center.city == cities[i]) cityIndex = i;
    }
  }

  int cityIndex = 0;
  TextEditingController centerName;
  TextEditingController description;
  TextEditingController centerStreet;

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
            width: MediaQuery.of(context).size.width,
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
                    controller: centerName,
                  ),
                ),
              )
            ]),
          ),
          Container(
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
                          cities[cityIndex],
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
          Container(
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
                    controller: centerStreet,
                  ),
                ),
              )
            ]),
          ),
          Container(
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
                      ),
                    ),
                  )
                ]),
          ),
          Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: CustomColor.interactable)),
              child: TextButton(
                  onPressed: () {
                    var jsonObject = {
                      'name': centerName.text,
                      'description': description.text,
                      'city': cities[cityIndex],
                    };
                    CampingCenterService.updateCenter(jsonObject).then((_) {
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(color: CustomColor.interactable),
                  )))
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
          onSelectedItemChanged: (index) => setState(() => cityIndex = index),
          children: modelBuilder<String>(
            cities,
            (index, value) {
              return Center(
                child: Text(
                  value,
                ),
              );
            },
          ),
        ),
      );
}
