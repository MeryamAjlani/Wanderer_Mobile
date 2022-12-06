import 'package:flutter/material.dart';

class ReservationEvent {
  String id;
  String eventId;
  String userEmail;
  double price;
  int places;
  int tent;
  int sleepingBag;
  DateTime date;
  bool status;

  ReservationEvent(
      {@required String id,
      @required String eventId,
      @required String userEmail,
      @required double price,
      @required int places,
      @required int tent,
      @required int sleepingBag,
      @required DateTime date,
      @required bool status})
      : this.id = id,
        this.eventId = eventId,
        this.userEmail = userEmail,
        this.price = price,
        this.places = places,
        this.tent = tent,
        this.sleepingBag = sleepingBag,
        this.date = date,
        this.status = status;

  factory ReservationEvent.fromJson(dynamic json) {
    return ReservationEvent(
        id: json['_id'],
        eventId: json['eventId'],
        userEmail: json['userEmail']['fullname'],
        price: json['price'] + 0.0,
        places: json['places'],
        tent: json['tent'],
        sleepingBag: json['sleepingBag'],
        date: DateTime.parse(json['date']),
        status: json['status']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['id'] = this.id;
    data['eventId'] = this.eventId;
    data['userEmail'] = this.userEmail;
    data['price'] = this.price;
    data['places'] = this.places;
    data['tent'] = this.tent;
    data['sleepingBag'] = this.sleepingBag;
    data['date'] = this.date.toIso8601String();
    data['status'] = this.status;
    return data;
  }
}
