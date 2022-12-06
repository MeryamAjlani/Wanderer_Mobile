import 'package:Wanderer/Modules/ReservationEventModule.dart';

import 'package:Wanderer/Services/ReservationEventsService.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ParticipantAccept extends StatelessWidget {
  final ReservationEvent reservation;
  final Function _refresh;
  ParticipantAccept(this.reservation, this._refresh);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: CustomColor.interactableAccent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reservation.userEmail,
                    style: TextStyle(
                        fontSize: 19, color: CustomColor.interactableAccent),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number of places:  ' + reservation.places.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text(
                          'Sleeping bags:  ' +
                              reservation.sleepingBag.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text(
                          'Tents:  ' + reservation.tent.toString(),
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 60,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    textColor: CustomColor.highlightText,
                    color: CustomColor.interactable,
                    onPressed: () {
                      ReservationEventsService.acceptParticipant(reservation.id)
                          .then((value) {
                        if (value.data["status"]) {
                          print('yes');
                          _refresh();
                        }
                      });
                    },
                    child: Icon(Icons.check)),
              ),
            ],
          ),
          Opacity(
            opacity: 0.41,
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              height: 1,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Remaining price:  ' + (reservation.price * 0.7).toString(),
                  style:
                      TextStyle(fontSize: 15, color: CustomColor.interactable),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
