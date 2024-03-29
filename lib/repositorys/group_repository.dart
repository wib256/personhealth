import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:personhealth/models/group.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';

Future<bool> rejectInvited(int familyId, int patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.delete(Uri.parse('$REJECT_INVITED$familyId/$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<bool> acceptInvited(int familyId, int patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.put(Uri.parse('$ACCEPT_INVITED$familyId/$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    print('$ACCEPT_INVITED$familyId/$patientId');
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}

Future<List<Group>> getInvitedGroup() async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_INVITED_GROUP$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<Group> groups = responseData.map<Group>((json) => Group.fromJson(json)).toList();
      return groups;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<bool> createGroup(String groupName, int leaderId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {
      "leaderId": leaderId,
      "name": groupName,
      "status": "enable"
    };
    Uri uri = Uri.parse('$CREATE_GROUP');
    final response = await http.post(uri, body: jsonEncode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
      var group = Group.fromJson(json);
      await postSharingInformationToGroup(false, false, false, group.id);
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    return false;
  }
}
