import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:personhealth/models/shared.dart';

import 'local_data.dart';

Future<bool> addMember(int familyGroupId, String phone) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.post(Uri.parse('$ADD_MEMBER/$familyGroupId/$phone'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<List<Sharing>> getSharingList() async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_SHARING_LIST$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Sharing> sharingList = responseData.map<Sharing>((json) => Sharing.fromJson(json)).toList();
      return sharingList;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<List<Shared>> getSharedList() async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_SHARED_LIST$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Shared> sharedList = responseData.map<Sharing>((json) => Shared.fromJson(json)).toList();
      return sharedList;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<bool> postSharingInformationToPatient(bool bodyIndex, bool legalInformation, bool prehistoricInformation, String phoneOfSharedPatient) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "bodyIndex": bodyIndex,
      "familyGroupId": 0,
      "legalInformation": legalInformation,
      "phoneOfSharedPatient": phoneOfSharedPatient,
      "prehistoricInformation": prehistoricInformation,
      "sharingPatientId": patientId
    };
    Uri uri = Uri.parse('$POST_SHARING_INFORMATION_TO_PATIENT');
    final response = await http.post(uri, body: jsonEncode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<bool> postSharingInformationToGroup(bool bodyIndex, bool legalInformation, bool prehistoricInformation, int familyGroupId) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "bodyIndex": bodyIndex,
      "familyGroupId": familyGroupId,
      "legalInformation": legalInformation,
      "prehistoricInformation": prehistoricInformation,
      "sharingPatientId": patientId
    };
    Uri uri = Uri.parse('$POST_SHARING_INFORMATION_TO_GROUP');
    final response = await http.post(uri, body: jsonEncode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<bool> editSharingInformationToGroup(bool bodyIndex, bool legalInformation, bool prehistoricInformation, int familyGroupId) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "bodyIndex": bodyIndex,
      "familyGroupId": familyGroupId,
      "legalInformation": legalInformation,
      "prehistoricInformation": prehistoricInformation,
      "sharedPatientId": 0,
      "sharingPatientId": patientId
    };
    Uri uri = Uri.parse('$EDIT_SHARING_INFORMATION_TO_GROUP');
    final response = await http.post(uri, body: jsonEncode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<bool> editSharingInformationToPatient(bool bodyIndex, bool legalInformation, bool prehistoricInformation, int id) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "bodyIndex": bodyIndex,
      "familyGroupId": 0,
      "legalInformation": legalInformation,
      "prehistoricInformation": prehistoricInformation,
      "sharedPatientId": id,
      "sharingPatientId": patientId
    };
    Uri uri = Uri.parse('$EDIT_SHARING_INFORMATION_TO_PATIENT');
    final response = await http.post(uri, body: jsonEncode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}