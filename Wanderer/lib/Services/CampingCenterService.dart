import 'dart:core';
import 'dart:io';
import 'dart:math';

import 'package:Wanderer/Modules/ListItemCenter.dart';
import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Modules/RatingModule.dart';

import 'package:dio/dio.dart';
import 'package:location/location.dart';

import 'Utility/DioService.dart';
import 'Utility/ImageService.dart';

class CampingCenterService {
  static Future<dynamic> getListSort(
      int page, int filterKey, LocationData loc) async {
    try {
      String long = '', lat = '';
      if (loc != null) {
        long = loc.longitude.toString();
        lat = loc.latitude.toString();
      }
      var response = await DioService.dio
          .post(DioService.url + 'CampingCentersSort', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'long': long,
        'lat': lat
      });
      print(DioService.cookieJar
          .loadForRequest(Uri.parse(DioService.url + 'CampingCenters')));

      var result = (response.data as List)
          .map((x) => ListItemCenter.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future<ListItemCenter> getOwnedCenter() async {
    print("getting owned center");
    var response =
        await DioService.dio.post(DioService.url + 'OwnedCampingCenter');
    print("server response recieved");
    var center = ListItemCenter.fromJson(response.data);
    return center;
  }

  static Future<dynamic> uploadPicture(File image) async {
    var data = await ImageService.prepareImageForUpload(image, null);
    try {
      return DioService.dio
          .post(DioService.url + 'uploadCenterPicture', data: data);
    } on DioError {}
  }

  static Future<dynamic> updatePrices(dynamic pricesList) async {
    await DioService.dio
        .post(DioService.url + 'updatePrices', data: pricesList);
  }

  static Future<dynamic> updateCenter(dynamic data) async {
    await DioService.dio.post(DioService.url + 'updateCenter', data: data);
  }

  static Future<dynamic> getListSearch(
      int page, int filterKey, String searchKey, LocationData loc) async {
    try {
      String long = '', lat = '';
      if (loc != null) {
        long = loc.longitude.toString();
        lat = loc.latitude.toString();
      }
      var response = await DioService.dio
          .post(DioService.url + 'CampingCentersSearch', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'searchKey': searchKey,
        'long': long,
        'lat': lat
      });
      print(DioService.cookieJar
          .loadForRequest(Uri.parse(DioService.url + 'CampingCenters')));

      var result = (response.data as List)
          .map((x) => ListItemCenter.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future addRandom() async {
    var newItem = {
      'name': 'Center' + Random().nextInt(1000).toString(),
      'picture': 'IlSogno',
      'description':
          'Lorem ipsum dolor sit amet. Est accusamus numquam est neque minus in voluptatem odio. Nam autem rerum qui iste dolorem aut repellat quaerat sed soluta iure',
      'city': 'placeholder',
      'rating': Random().nextInt(5),
      'numbRating': Random().nextInt(200),
      'location': {
        'type': 'Point',
        'coordinates': [
          30.29 + Random().nextDouble() * 7.1,
          7.61618 + Random().nextDouble() * 4.1
        ]
      },
      'status': true,
      'price': Random().nextInt(20),
    }
        //'coordonates_x': 30.29 + Random().nextDouble() * 7.1,
        //'coordonates_y': 7.61618 + Random().nextDouble() * 4.1,
        ;
    await DioService.dio.post(DioService.url + 'addCenter', data: newItem);
    return;
  }

  static Future<dynamic> getCenterPrices(String centerID) async {
    try {
      var response = await DioService.dio.post(
          DioService.url + 'getCamingCenterPrices',
          data: {'center': centerID});
      var list =
          (response.data as List).map((x) => PriceItem.fromJson(x)).toList();
      return list;
    } on DioError {}
  }

  static Future<dynamic> getCenterRatingsBM(String centerID) async {
    try {
      var response = await DioService.dio
          .post(DioService.url + 'ratings', data: {'center': centerID});
      print("response " + response.toString());
      var list =
          (response.data as List).map((x) => RatingModule.fromJson(x)).toList();
      return list;
    } on DioError {}
  }

  static Future<dynamic> rateCenter(
      String content, double rating, String userName, String centerID) async {
    try {
      var response = await DioService.dio.post(DioService.url + 'addratings',
          data: {
            'content': content,
            'rating': rating,
            'name': userName,
            'center': centerID
          });

      return response;
    } on DioError {}
  }

  static Future<dynamic> getUserRating(String centerID) async {
    try {
      var response = await DioService.dio
          .post(DioService.url + 'getUserRating', data: {'center': centerID});
      print("data" + response.data.length.toString());
      if (response.data.length != 0 && response.data[0] != null) {
        var rating = RatingModule.fromJson(response.data[0]);
        return rating;
      } else {
        return null;
      }
    } on DioError {}
  }

  static Future<dynamic> modifyUserRating(
      String content, double rating, String center) async {
    try {
      var response = await DioService.dio.post(DioService.url + 'updateRating',
          data: {'content': content, 'rating': rating, 'center': center});
      return response;
    } on DioError {}
  }
}
