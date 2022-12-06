import 'package:flutter/material.dart';

class MarketPlaceItemModule {
  final String itemID;
  final String previewPicture;
  final List pictures;
  final String name;
  final String price;
  final String brand;
  final String description;
  final String userNumber;
  final String userName;
  final String userImage;
  final String city;

  MarketPlaceItemModule(
      {@required String itemID,
      @required String previewPicture,
      @required List pictures,
      @required String name,
      @required String price,
      @required String brand,
      @required String description,
      @required String userNumber,
      @required String userName,
      @required String userImage,
      @required String city})
      : this.itemID = itemID,
        this.pictures = pictures,
        this.name = name,
        this.price = price,
        this.brand = brand,
        this.description = description,
        this.userNumber = userNumber,
        this.userName = userName,
        this.city = city,
        this.userImage = userImage,
        this.previewPicture = previewPicture;

  factory MarketPlaceItemModule.fromJson(dynamic json) {
    return MarketPlaceItemModule(
        previewPicture: json['previewPicture'],
        userImage: json['userImage'],
        city: json['city'],
        brand: json['brand'],
        itemID: json['itemID'],
        name: json['name'],
        price: json['price'].toString(),
        userNumber: json['userNumber'],
        userName: json['userName'],
        description: json['description'],
        pictures: json['pictures'] as List);
  }
}
