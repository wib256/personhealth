import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:http/http.dart' as http;

import 'local_data.dart';

Future<List<Clinic>> getClinicsFromApi() async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse(GET_CLINIC_FROM_API), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Clinic> clinics = responseData.map<Clinic>((json) => Clinic.fromJson(json)).toList();
      return clinics;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<List<Clinic>> getClinicsByNameFromApi(String searchName) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_CLINICS_BY_NAME_FROM_API$searchName'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Clinic> clinics = responseData.map<Clinic>((json) => Clinic.fromJson(json)).toList();
      return clinics;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}