import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:intl/intl.dart';

class OrganizedEvent {
  String id;
  String name;
  String startCity;
  String picture;
  LatLng startLocation;
  String description;
  double price;
  double distanceInKm;
  int totalPlaces;
  int nbParticipants;
  DateTime date;
  int numbdays;
  String street;
  String previewPicture;
  int availablePlaces;
  String orgId;
  bool featured;

  OrganizedEvent(
      {@required String id,
      @required String name,
      @required String description,
      @required double price,
      @required double distanceInKm,
      @required int totalPlaces,
      @required int nbParticipants,
      @required DateTime date,
      @required int numbdays,
      @required double coordLat,
      @required double coordLng,
      @required String startCity,
      @required String picture,
      @required String street,
      @required String orgId,
      @required bool featured})
      : this.id = id,
        this.name = name,
        this.description = description,
        this.price = price,
        this.distanceInKm = distanceInKm,
        this.totalPlaces = totalPlaces,
        this.nbParticipants = nbParticipants,
        this.date = date,
        this.numbdays = numbdays,
        this.availablePlaces = totalPlaces - nbParticipants,
        this.startCity = startCity,
        this.startLocation = LatLng(coordLat, coordLng),
        this.picture = picture,
        this.previewPicture = ImageService.imageUrl(picture),
        this.street = street,
        this.orgId = orgId,
        this.featured = featured;

  void updatePreviewPicture(String picture) {
    this.picture = picture;
    this.previewPicture = ImageService.imageUrl(picture);
  }

  factory OrganizedEvent.init() {
    return OrganizedEvent(
        id: '',
        name: '',
        description: '',
        price: 0.0,
        distanceInKm: 0,
        totalPlaces: 0,
        nbParticipants: 0,
        date: DateTime.now(),
        numbdays: 1,
        coordLat: 0,
        coordLng: 0,
        startCity: 'Ariana',
        picture: 'placeholder-image_rectangle',
        street: '',
        orgId: '0',
        featured: false);
  }
  factory OrganizedEvent.fromJson(dynamic json) {
    return OrganizedEvent(
        price: json['price'] + 0.0,
        coordLat: json['location']['coordinates'][0] + 0.0,
        coordLng: json['location']['coordinates'][1] + 0.0,
        id: json['_id'],
        picture: json['picture'],
        name: json['name'],
        startCity: json['startCity'],
        distanceInKm: json['distanceInKm'] + 0.0,
        description: json['description'],
        totalPlaces: json['totalPlaces'],
        nbParticipants: json['nbParticipants'],
        street: json['street'],
        orgId: json['orgId'],
        date: DateTime.parse(json['date']),
        numbdays: json['numbdays'],
        featured: json['featured']);
  }
  dynamic toJson() {
    dynamic event = {
      '_id': id,
      'name': name,
      'description': description,
      'startCity': startCity,
      'street': street,
      'price': price,
      'distanceInKm': distanceInKm,
      'totalPlaces': totalPlaces,
      'nbParticipants': nbParticipants,
      'location': {
        'type': 'Point',
        'coordinates': [startLocation.latitude, startLocation.longitude]
      },
      'date': date.toIso8601String(),
      'numbdays': numbdays,
      'featured': featured,
      'orgId': orgId,
      'picture': picture,
    };
    return event;
  }
}
