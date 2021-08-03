import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<String?> updateToken(String fcm_token) async {
  String? phone = await LocalData().getPhone();
  String? token = await LocalData().getToken();
  token = 'Bearer ' + token!;
  var params = {"fcm_token": fcm_token, "phone": phone};
  final response = await http
      .put(Uri.parse('$UPDATE_TOKEN'), body: json.encode(params), headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "*/*",
    HttpHeaders.authorizationHeader: token
  });

  print(response.body);
  if (response.statusCode == 200) {
    String result = response.body.toString();
    return result;
  } else {
    return '';
  }
}

Future<String?> sentNotification(int acccountReceiveId, String message) async {
  String? token = await LocalData().getToken();
  token = 'Bearer ' + token!;
  var params = {"accountId": acccountReceiveId, "message": message};
  final response = await http
      .post(Uri.parse('$SENT_NOTIFICATION'), body: json.encode(params), headers: {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "*/*",
    HttpHeaders.authorizationHeader: token
  });

  print(response.body);
  if (response.statusCode == 200) {
    String result = response.body.toString();
    return result;
  } else {
    return '';
  }
}
