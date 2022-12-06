import 'package:flutter/material.dart';

class Previews {
  final List listBoots;
  final List listJackets;
  final List listSleepingBags;
  final List listUtensils;
  final List listMattresses;
  final List listlamps;
  final List listChairs;
  final List listKits;
  final List listTents;

  Previews(
      {@required List listBoots,
      @required List listJackets,
      @required List listTents,
      @required List listSleepingBags,
      @required List listUtensils,
      @required List listMattresses,
      @required List listlamps,
      @required List listChairs,
      @required List listKits})
      : this.listBoots = listBoots,
        this.listJackets = listJackets,
        this.listTents = listTents,
        this.listSleepingBags = listSleepingBags,
        this.listUtensils = listUtensils,
        this.listMattresses = listMattresses,
        this.listlamps = listlamps,
        this.listChairs = listChairs,
        this.listKits = listKits;

  factory Previews.fromJson(dynamic json) {
    return Previews(listBoots: json['listBoots'],
    listJackets: json['listJackets'],
    listTents: json['listTents'],
    listSleepingBags:json['listSleepingBags'],
    listUtensils:json['listUtensils'],
    listMattresses:json['listMattresses'],
    listlamps:json['listlamps'],
    listChairs:json['listChairs'],
    listKits:json['listKits']
    );
  }
}
