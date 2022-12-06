import 'dart:io';

import 'package:Wanderer/Modules/Profile.dart';

import 'package:dio/dio.dart';

import 'Utility/DioService.dart';
import 'Utility/ImageService.dart';

class ProfileService {
  static Future<dynamic> loadProfile(email) async {
    try {
      return DioService.dio.get(DioService.url + 'loadProfile/' + email);
    } on DioError {}
  }

  static Future<dynamic> updateProfile(ProfileModel profile) async {
    try {
      return DioService.dio.post(DioService.url + 'updateProfile', data: {
        "gender": profile.gender,
        "dateOfBirth": profile.dob,
        "city": profile.city
      });
    } on DioError {}
  }

  static Future<dynamic> updateProfilePicture(File image) async {
    var data = await ImageService.prepareImageForUpload(image, null);
    try {
      return DioService.dio
          .post(DioService.url + 'uploadProfilePicture', data: data);
    } on DioError {}
  }
}
