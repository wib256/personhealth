import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/user_family_group.dart';
import 'package:http/http.dart' as http;

import 'local_data.dart';

Future<List<UserFamilyGroup>> getListGroup(patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_LIST_GROUP$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body).cast<Map<String, dynamic>>();
      final List<UserFamilyGroup> list = responseData.map<UserFamilyGroup>((json) => UserFamilyGroup.fromJson(json)).toList();
      return list;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print('Error get list group: $exception');
    return List.empty();
  }
}