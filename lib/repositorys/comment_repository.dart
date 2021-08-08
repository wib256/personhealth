import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/comment.dart';
import 'package:http/http.dart' as http;

import 'local_data.dart';

Future<List<Comment>> getListComment(int clinicId) async {
  try{
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_COMMENT$clinicId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      List<Comment> comments = responseData.map<Comment>((json) => Comment.fromJson(json)).toList();
      return comments;
    } else {
      print('Get comments fail');
      return List.empty();
    }
  } catch (exception) {
    print(exception);
    return List.empty();
  }

}