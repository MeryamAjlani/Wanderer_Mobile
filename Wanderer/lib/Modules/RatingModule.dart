import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingModule {
  final String content;
  final String userName;
  final double rating;
  final RatingSpecial special;
  final DateTime date;

  RatingModule(
      {@required String content,
      @required String userName,
      @required double rating,
      @required DateTime date,
      RatingSpecial special: RatingSpecial.Normal})
      : this.content = content,
        this.rating = rating,
        this.special = special,
        this.userName = userName,
        this.date = date;

  bool isNormal() {
    return special == RatingSpecial.Normal;
  }

  String specialText() {
    switch (special) {
      case RatingSpecial.Best:
        return "best-review";
      case RatingSpecial.Worst:
        return "worst-review";
      case RatingSpecial.Own:
        return "your-review";
      default:
        return null;
    }
  }

  Color specialColor() {
    switch (special) {
      case RatingSpecial.Best:
        return Colors.green;
      case RatingSpecial.Worst:
        return Colors.red;
      case RatingSpecial.Own:
        return Colors.blue;
      default:
        return null;
    }
  }

  RatingModule asBest() {
    return RatingModule(
        content: this.content,
        userName: this.userName,
        rating: this.rating,
        date: this.date,
        special: RatingSpecial.Best);
  }

  RatingModule asWorst() {
    return RatingModule(
        content: this.content,
        userName: this.userName,
        rating: this.rating,
        date: this.date,
        special: RatingSpecial.Worst);
  }

  RatingModule asOwn() {
    return RatingModule(
        content: this.content,
        userName: this.userName,
        rating: this.rating,
        date: this.date,
        special: RatingSpecial.Own);
  }

  factory RatingModule.fromJson(dynamic json) {
    return RatingModule(
        content: json['content'],
        date: DateTime.parse(json['date']),
        rating: json['rating'] + 0.0,
        userName: json['userName']);
  }
}

enum RatingSpecial { Normal, Best, Worst, Own }
