import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:flutter/material.dart';

class CampingLocation {
  final String locationID;
  final String picture;
  final String previewPicture;
  final String smallPicture;
  final String name;
  double avgRating;
  int numbRating;
  final String city;
  final String description;
  final String street;
  final double coordLat;
  final double coordLon;

  CampingLocation({
    @required String locationID,
    @required String picture,
    @required String name,
    @required double avgRating,
    @required int numbRating,
    @required String city,
    @required String description,
    @required String street,
    @required double coordLat,
    @required double coordLon,
  })  : this.avgRating = avgRating,
        this.locationID = locationID,
        this.city = city,
        this.coordLat = coordLat,
        this.coordLon = coordLon,
        this.description = description,
        this.name = name,
        this.picture = picture,
        this.street = street,
        this.previewPicture = ImageService.imageUrl(picture, width: 600),
        this.smallPicture =
            ImageService.imageUrl(picture, width: 64, height: 64),
        this.numbRating = numbRating;

  factory CampingLocation.fromJson(dynamic json) {
    return CampingLocation(
        locationID: json['_id'],
        picture: json['picture'],
        name: json['name'],
        avgRating: json['rating'] + 0.0,
        numbRating: json['numbRating'],
        city: json['city'],
        description: json['description'],
        street: "place holder street adress",
        coordLat: json['location']['coordinates'][0],
        coordLon: json['location']['coordinates'][1]);
  }
}
