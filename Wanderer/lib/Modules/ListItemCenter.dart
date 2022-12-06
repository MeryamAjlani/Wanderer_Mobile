import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:flutter/material.dart';

class ListItemCenter {
  final String centerID;
  final String picture;
  final String previewPicture;
  final String name;
  double avgRating;
  int numbRating;
  final String city;
  final String description;
  final String street;
  final double coordLat;
  final double coordLon;
  final bool status;
  double accessPrice;

  ListItemCenter(
      {@required String centerID,
      @required String picture,
      @required String name,
      @required double avgRating,
      @required int numbRating,
      @required String city,
      @required String description,
      @required String street,
      @required double coordLat,
      @required double coordLon,
      @required bool status,
      @required double accessPrice})
      : this.accessPrice = accessPrice,
        this.avgRating = avgRating,
        this.centerID = centerID,
        this.city = city,
        this.coordLat = coordLat,
        this.coordLon = coordLon,
        this.description = description,
        this.name = name,
        this.picture = picture,
        this.status = status,
        this.street = street,
        this.previewPicture = ImageService.imageUrl(picture, width: 600),
        this.numbRating = numbRating;

  ListItemCenter changePicture(String image) {
    return ListItemCenter(
        centerID: this.centerID,
        picture: image,
        name: this.name,
        avgRating: this.avgRating,
        numbRating: this.numbRating,
        city: this.city,
        description: this.description,
        street: this.street,
        coordLat: this.coordLat,
        coordLon: this.coordLon,
        status: this.status,
        accessPrice: this.accessPrice);
  }

  factory ListItemCenter.fromJson(dynamic json) {
    return ListItemCenter(
        centerID: json['_id'],
        picture: json['picture'],
        name: json['name'],
        avgRating: json['rating'] + 0.0,
        numbRating: json['numbRating'],
        city: json['city'],
        description: json['description'],
        street: "place holder street adress",
        coordLat: json['location']['coordinates'][0],
        coordLon: json['location']['coordinates'][1],
        status: json['status'],
        accessPrice: json['price'] + 0.0);
  }
}
