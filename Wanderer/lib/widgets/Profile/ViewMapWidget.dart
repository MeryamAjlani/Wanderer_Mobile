import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewMapWidget extends StatefulWidget {
  ViewMapWidget();

  @override
  _ViewMapWidgetState createState() => _ViewMapWidgetState();
}

class _ViewMapWidgetState extends State<ViewMapWidget> {
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter2 = new DateFormat('MM-dd-yyyy');

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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: <Widget>[
              /*
              Image.asset(
                'assets/Images/ProfileMap/0.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/1.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/2.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/3.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/4.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/5.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/6.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/7.png',
                height: 410,
              ), 
              Image.asset(
                'assets/Images/ProfileMap/8.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/9.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/10.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/11.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/12.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/13.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/14.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/15.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/16.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/17.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/18.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/19.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/20.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/21.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/22.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/23.png',
                height: 410,
              ),
              Image.asset(
                'assets/Images/ProfileMap/complete.png',
                height: 410,
              )*/
            ],
          ),
        )
      ],
    );
  }
}
