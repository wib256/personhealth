import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/group_family.dart';
import 'package:http/http.dart' as http;

import 'local_data.dart';

Future<GroupFamily?> getGroupFamilyDetailFromApi(int familyId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_GROUP_FAMILY_DETAIL$familyId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var groupFamily = GroupFamily.fromJson(parse);
      return groupFamily;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception);
    return null;
  }
}

