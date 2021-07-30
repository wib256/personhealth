import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/rating.dart';
import 'package:http/http.dart' as http;

Future<String> rateExamination(Rating rating) async {
  try {
    var param = {
      "comment": rating.comment,
      "examinationId": rating.examinationId,
      "rate": rating.rate,
    };
    print(param);
    Uri uri = Uri.parse('$POST_RATING');

    final response = await http.post(uri, body: json.encode(param), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    });

    if (response.statusCode == 200) {
      return "Succeeded!";
    } else {
      return "The system is maintenance. Please try again later!";
    }
  } catch (exception) {
    return "The system is maintenance. Please try again later!";
  }
}
