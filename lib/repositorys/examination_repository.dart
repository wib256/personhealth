import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/examination.dart';
import 'package:http/http.dart' as http;

import 'local_data.dart';

Future<List<Examination>> getExaminationsByPatientIdFromApi(int patientID) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_EXAMINATION_BY_PATIENTID_FROM_API$patientID'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Examination> examinations = responseData.map<Examination>((json) => Examination.fromJson(json)).toList();
      return examinations;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<List<Examination>> getExaminationsByDateFromApi(int patientID, String dateFrom, String dateTo) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
        "dateF": dateFrom,
        "dateT": dateTo,
        "patientId": patientID
    };
    Uri uri = Uri.parse('$GET_EXAMINATION_BY_DATE_FROM_API');

    final response = await http.post(uri, body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.acceptHeader: "application/json", HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Examination> examinations = responseData.map<Examination>((json) => Examination.fromJson(json)).toList();
      return examinations;
    } else {
      return List.empty();
    }

  } catch (exception) {
    return List.empty();
  }
}