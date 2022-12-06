import 'dart:core';
import 'dart:io';

import 'package:Wanderer/Modules/OrganizedEvent.dart';

import 'package:dio/dio.dart';
import 'package:location/location.dart';

import 'Utility/DioService.dart';
import 'Utility/ImageService.dart';

class EventService {
  static Future<dynamic> getListSort(
      int page, int filterKey, LocationData loc) async {
    try {
      String long = '', lat = '';
      if (loc != null) {
        long = loc.longitude.toString();
        lat = loc.latitude.toString();
      }
      var response = await DioService.dio
          .post(DioService.url + 'OrganizedEventSort', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'long': long,
        'lat': lat
      });
      var result = (response.data as List)
          .map((x) => OrganizedEvent.fromJson(x))
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
          .post(DioService.url + 'OrganizedEventSearch', data: {
        'page': page.toString(),
        'filterKey': filterKey.toString(),
        'searchKey': searchKey,
        'long': long,
        'lat': lat
      });
      var result = (response.data as List)
          .map((x) => OrganizedEvent.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future createOrgEvent(OrganizedEvent org) async {
    return await DioService.dio
        .post(DioService.url + 'addOrganizedEvent', data: org.toJson());
  }

  static Future updateOrgEvent(OrganizedEvent req) async {
    return await DioService.dio.post(DioService.url + 'updateOrganizedEvent',
        data: {'event': req.toJson()});
  }

  static Future<dynamic> updateOrgEventPicture(File image, String id) async {
    var data = await ImageService.prepareImageForUpload(image, id);
    try {
      return DioService.dio
          .post(DioService.url + 'updateOrganizedEventImage', data: data);
    } on DioError {}
  }
}
