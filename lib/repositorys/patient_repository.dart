import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:personhealth/repositorys/local_data.dart';

Future<Patient?> getPatientByIdFromApi(int patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response =
        await http.get(Uri.parse('$GET_PATIENT_BY_ID_FROM_API$patientId'), headers: {
          HttpHeaders.authorizationHeader: token
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var patient = Patient.fromJson(parse);
      return patient;
    } else {
      return null;
    }
  } catch (exception) {
    return null;
  }
}

Future<Patient?> getPatientByPhoneFromApi(String phone) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response =
        await http.get(Uri.parse('$GET_PATIENT_BY_PHONE_FROM_API$phone'), headers:{
          HttpHeaders.authorizationHeader: token
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var patient = Patient.fromJson(parse);
      return patient;
    } else {
      return null;
    }
  } catch (exception) {
    return null;
  }
}

Future<Patient?> getDataSharingOfPatient(int familyId, int patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {"familyGroupId": familyId, "sharingPatientId": patientId};
    Uri uri = Uri.parse('$GET_DATA_SHARING_OF_PATIENT');
    final response = await http.post(uri, body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var patient = Patient.fromJson(parse);
      patient.setId(patientId);
      return patient;
    } else {
      return null;
    }
  } catch (exception) {
    return null;
  }
}
