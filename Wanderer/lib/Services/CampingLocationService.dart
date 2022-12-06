import 'dart:core';
import 'dart:math';

import 'package:Wanderer/Modules/CampingLocation.dart';
import 'package:dio/dio.dart';

import 'package:location/location.dart';

import 'Utility/DioService.dart';

class CampingLocationService {
  static Future<dynamic> getList() async {
    try {
      var response = await DioService.dio.get(
        DioService.url + 'getCampingLocationList',
      );
      var result = (response.data as List)
          .map((x) => CampingLocation.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future<dynamic> getListSort(
      int page, int filterKey, LocationData loc) async {
    try {
      String long = '', lat = '';
      if (loc != null) {
        long = loc.longitude.toString();
        lat = loc.latitude.toString();
      }
      var response =
          await DioService.dio.post(DioService.url + 'CampingSitesSort', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'long': long,
        'lat': lat
      });
      var result = (response.data as List)
          .map((x) => CampingLocation.fromJson(x))
          .toList();
      return result;
    } on DioError {}
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
          .post(DioService.url + 'CampingSitesSearch', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'searchKey': searchKey,
        'long': long,
        'lat': lat
      });
      var result = (response.data as List)
          .map((x) => CampingLocation.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future addRandom() async {
    var newItem = {
      'name': 'campingLocation' + Random().nextInt(1000).toString(),
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
        ],
      },
      //'coordonates_x': 30.29 + Random().nextDouble() * 7.1,
      //'coordonates_y': 7.61618 + Random().nextDouble() * 4.1,
    };
    await DioService.dio
        .post(DioService.url + 'addCampingLocation', data: newItem);
    return;
  }
}
