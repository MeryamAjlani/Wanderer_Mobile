import 'package:Wanderer/Modules/ReservationEventModule.dart';
import 'package:Wanderer/Screens/Organization/MyReservations.dart';

import 'package:Wanderer/Services/ReservationEventsService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:Wanderer/Modules/OrganizedEvent.dart';

class ReservationRequestWidget extends StatefulWidget {
  final OrganizedEvent event;
  final String userEmail;
  final double tents;
  final double sleepingBags;

  ReservationRequestWidget(this.userEmail, this.event)
      : this.tents = 10,
        this.sleepingBags = 5;

  @override
  _ReservationRequestWidgetState createState() =>
      _ReservationRequestWidgetState();
}

class _ReservationRequestWidgetState extends State<ReservationRequestWidget> {
  var formatter = new DateFormat('yyyy-MM-dd');
  var formatter2 = new DateFormat('MM-dd-yyyy');
  TextEditingController totalPlaces;
  TextEditingController tent;
  TextEditingController sleepingBags;

  double priceP = 0;
  double priceT = 0;
  double priceB = 0;
  double price = 0;

  @override
  void initState() {
    totalPlaces = new TextEditingController(text: '1');
    tent = new TextEditingController(text: '0');

    sleepingBags = new TextEditingController(text: '0');
    setState(() {
      priceP = widget.event.price;
      price = priceP + priceT + priceB;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text('Number of places: ', style: TextStyle(color: Colors.white70)),
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
                  onChanged: (value) {
                    setState(() {
                      priceP = int.parse(totalPlaces.text) * widget.event.price;
                      price = priceB + priceT + priceP;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Text('Number of tents: ', style: TextStyle(color: Colors.white70)),
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
                  controller: tent,
                  onChanged: (value) {
                    print(widget.tents);
                    setState(() {
                      priceT = int.parse(tent.text) * widget.tents;
                      price = priceB + priceT + priceP;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Text('Number of sleeping bags: ',
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
                  controller: sleepingBags,
                  onChanged: (value) {
                    setState(() {
                      priceB =
                          int.parse(sleepingBags.text) * widget.sleepingBags;
                      price = priceB + priceT + priceP;
                    });
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Text('Total price: ', style: TextStyle(color: Colors.white70)),
            Text(price.toString(), style: TextStyle(color: Colors.white70)),
          ],
        ),
        Row(
          children: [
            Text('Reservation fee: ', style: TextStyle(color: Colors.white70)),
            Text((price * 0.3).toString(),
                style: TextStyle(color: Colors.white70)),
          ],
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text('Notice : ',
              style: TextStyle(
                  color: CustomColor.interactableAccent, fontSize: 18)),
        ),
        Text(
            'Your reservation will expire in 2 days if the reservation fee is not paid! ',
            style: TextStyle(color: Colors.white70)),
        Container(
          margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: OutlineButton(
            padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            borderSide: BorderSide(color: CustomColor.interactable, width: 2),
            child: Text(
              'Make a reservation',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: CustomColor.interactable),
            ),
            onPressed: () {
              ReservationEvent eveRes = new ReservationEvent(
                  id: "0000",
                  eventId: widget.event.id,
                  userEmail: widget.userEmail,
                  price: price,
                  places: int.parse(totalPlaces.text),
                  tent: int.parse(tent.text),
                  sleepingBag: int.parse(sleepingBags.text),
                  date: DateTime.now(),
                  status: false);

              ReservationEventsService.makeReservation(eveRes)
                  .then((value) => {
                        print(value.toString()),
                        Navigator.of(context)
                            .pushNamed(MyReservations.routeName)
                      })
                  .catchError((error) => print(error));
            },
          ),
        ),
      ],
    );
  }
}
