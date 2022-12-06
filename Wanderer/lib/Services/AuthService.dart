import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Utility/DioService.dart';

class AuthService {
  static bool hasCookie() {
    return DioService.cookieJar
            .loadForRequest(Uri.parse(DioService.url + 'login'))
            .length !=
        0;
  }

  static Future<dynamic> login(email, password) async {
    try {
      return DioService.dio.post(DioService.url + 'login',
          data: {"email": email, "password": password});
    } on DioError {}
  }

  static Future<dynamic> autoLogin() async {
    try {
      return DioService.dio.post(DioService.url + 'autoLogin');
    } on DioError {}
  }

  static Future<dynamic> logout() async {
    try {
      return DioService.dio.post(DioService.url + 'logout');
    } on DioError {}
  }

  static Future<dynamic> register(email, password, name) async {
    try {
      return DioService.dio.post(DioService.url + "register",
          data: {"email": email, "password": password, "fullname": name});
    } on DioError {}
  }

  static Future<dynamic> reset(email) async {
    try {
      return DioService.dio.post(DioService.url + 'resetPassword', data: {
        "email": email,
      });
    } on DioError {}
  }

  static Future<dynamic> confirmCode(code, email) async {
    try {
      return DioService.dio.post(DioService.url + 'confirmCode',
          data: {"code": code, "email": email});
    } on DioError {}
  }

  static Future<dynamic> sendNewPassword(String email, String pass) {
    try {
      return DioService.dio.post(DioService.url + 'changePassword',
          data: {"pass": pass, "email": email});
    } on DioError {}
  }

  static Color getColorByEvent(String message) {
    if (message != "") return Colors.yellow;
    return Colors.white70;
  }
}
