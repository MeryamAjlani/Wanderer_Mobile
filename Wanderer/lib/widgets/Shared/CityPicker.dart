import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityPicker extends StatefulWidget {
  //final OrganizationModel profile;
  final Function _returnValue;

  CityPicker(this._returnValue);

  @override
  _CityPickerState createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
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
          onSelectedItemChanged: (index) => widget._returnValue(cities[index]),
          // setState(() => widget.profile.city = cities[index]),
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
  @override
  Widget build(BuildContext context) {
    return Container(child: cityPicker());
  }
}
