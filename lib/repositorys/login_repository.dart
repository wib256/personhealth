import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/repositorys/local_data.dart';

Future<bool> login(String username, String password) async {
  try {
    var params = {
        "password": password,
        "username": username
    };
    final response = await http.post(Uri.parse('$LOGIN'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (response.statusCode == 200) {
      String token = response.body.toString();
      await LocalData().saveToken(token);
      await LocalData().savePhone(username);
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print(exception);
    return false;
  }
}