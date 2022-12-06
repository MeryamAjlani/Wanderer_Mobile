import 'dart:core';

import 'package:Wanderer/Modules/ReservationEventModule.dart';

import 'Utility/DioService.dart';

class ReservationEventsService {
  static Future makeReservation(ReservationEvent req) async {
    return await DioService.dio.post(DioService.url + 'makeReservationEvent',
        data: {'reservation': req.toJson()});
  }

  static Future getEventStats(String id) async {
    return await DioService.dio
        .post(DioService.url + 'getEventsStats', data: {'eventId': id});
  }

  static Future acceptReservation(String id) async {
    return await DioService.dio.post(DioService.url + 'acceptReservation',
        data: {'reservationId': id});
  }

  static Future deleteReservation(String id) async {
    return await DioService.dio.post(DioService.url + 'acceptReservation',
        data: {'reservationId': id});
  }

  static Future acceptParticipant(String id) async {
    return await DioService.dio.post(DioService.url + 'acceptReservation',
        data: {'reservationId': id});
  }

  static Future getMyEventReservations(String id) async {
    var response = await DioService.dio
        .post(DioService.url + 'getReservationsByEvent', data: {'eventId': id});
    var result = (response.data as List)
        .map((x) => ReservationEvent.fromJson(x))
        .toList();
    print(result);
    return result;
  }

  static Future getMyReservations() async {
    var response = await DioService.dio
        .post(DioService.url + 'getMyReservations', data: null);
    var result = (response.data as List)
        .map((x) => ReservationEvent.fromJson(x))
        .toList();
    print(result);
    return result;
  }

  static Future getMyEventParticipants(String id) async {
    var response = await DioService.dio
        .post(DioService.url + 'getParticipantsByEvent', data: {'eventId': id});
    var result = (response.data as List)
        .map((x) => ReservationEvent.fromJson(x))
        .toList();
    print(result);
    return result;
  }
}
