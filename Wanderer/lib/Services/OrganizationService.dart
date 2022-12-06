import 'dart:io';

import 'package:Wanderer/Modules/Organization.dart';
import 'package:Wanderer/Modules/OrganizedEvent.dart';

import 'package:dio/dio.dart';

import 'Utility/DioService.dart';
import 'Utility/ImageService.dart';

class OrganizationService {
  static Future<dynamic> loadProfile(String email) async {
    try {
      return DioService.dio.get(DioService.url + 'loadOrganization/' + email);
    } on DioError {}
  }

  static Future<dynamic> updateProfile(OrganizationModel org) async {
    try {
      return DioService.dio.post(DioService.url + 'updateOrganization', data: {
        "description": org.description,
        "dateOfCreation": org.doc,
        "city": org.city,
        "phoneNumber": org.phone,
        "tents": org.tents,
        "sleepingBags": org.sleepingBags,
      });
    } on DioError {}
  }

  static Future<dynamic> updateProfilePicture(File image) async {
    var data = await ImageService.prepareImageForUpload(image, null);
    try {
      return DioService.dio
          .post(DioService.url + 'uploadPictureOrganization', data: data);
    } on DioError {}
  }

  static Future<dynamic> getMyEventsUpcoming(String email) async {
    try {
      var response = await DioService.dio.post(
          DioService.url + 'loadMyEventsUpcoming',
          data: {'email': email});
      var result = (response.data as List)
          .map((x) => OrganizedEvent.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future<dynamic> getMyEventsPast(int page, String email) async {
    try {
      var response = await DioService.dio.post(
          DioService.url + 'loadMyEventsPast',
          data: {'page': page.toString(), 'email': email});
      var result = (response.data as List)
          .map((x) => OrganizedEvent.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }
}
