import 'dart:io';
import 'package:Wanderer/Modules/MarketPlaceItemModule.dart';
import 'package:Wanderer/Modules/PreviewProduct.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Utility/DioService.dart';
import 'Utility/ImageService.dart';

class MarketPlaceService {
  static Future<dynamic> getList(int catalogueIndex) async {
    try {
      var response =
          await DioService.dio.post(DioService.url + 'getCategory', data: {
        'index': catalogueIndex,
      });
      var result = (response.data as List)
          .map((x) => MarketPlaceItemModule.fromJson(x))
          .toList();
      return result;
    } on DioError {}
  }

  static Future<dynamic> search(String searchKey) async {
    try {
      var response =
          await DioService.dio.post(DioService.url + 'searchProduct', data: {
        'key': searchKey,
      });
      var result = (response.data as List)
          .map((x) => MarketPlaceItemModule.fromJson(x))
          .toList();
      print(result);
      return result;
    } on DioError {}
  }

  static Future<dynamic> getPreview() async {
    try {
      var result = await DioService.dio.post(DioService.url + 'getPreview');
      var listPreview =
          (result.data as List).map((x) => PreviewPicture.fromJson(x)).toList();
      return listPreview;
    } on DioError {}
  }

  static Future<dynamic> addProduct(Map informations, List<File> images) async {
    try {
      Map<String, String> info = {
        'pname': informations['Product Name'],
        'price': informations['Product Price'].toString(),
        'brand': informations['Brand'],
        'description': informations['Description'],
        'userNumber': informations['Phone Number'],
        'city': informations['City'],
        'category': informations['Category'].toString(),
        //'pictures': data
      };
      var result = await DioService.dio.post(DioService.url + 'addProduct',
          data: await ImageService.prepareImagesForUpload(images, info));
      return result;
    } on DioError {}
  }

  static Color getColorByEvent(bool message) {
    if (!message) return Colors.yellow;
    return Colors.white70;
  }
}
