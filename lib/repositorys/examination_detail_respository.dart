import 'dart:convert';
import 'dart:io';

import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/examination_detail.dart';
import 'package:http/http.dart' as http;
import 'package:personhealth/models/graph_data.dart';

import 'local_data.dart';

Future<List<ExaminationDetail>> getExaminationsDetailFromApi(int examinationID, String gender) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_EXAMINATION_DETAIL_BY_EXAMINATIONID_FROM_API$examinationID?typeGender=$gender'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

      final List<ExaminationDetail> examinationsDetail = responseData.map<ExaminationDetail>((json) => ExaminationDetail.fromJson(json)).toList();
      return examinationsDetail;
    } else {
      return List.empty();
    }
  } catch (exception) {
    return List.empty();
  }
}

Future<List<GraphData>> getDataForGraph(int testId) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.get(Uri.parse('$GET_DATA_FOR_GRAPH$testId/$patientId'), headers: {
      HttpHeaders.authorizationHeader: token
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();
      final List<GraphData> graphData = responseData.map<GraphData>((json) => GraphData.fromJson(json)).toList();
      return graphData;
    } else {
      return List.empty();
    }
  } catch (exception) {
    print(exception);
    return List.empty();
  }
}