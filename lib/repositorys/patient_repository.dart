import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/patient.dart';
import 'package:http/http.dart' as http;
import 'package:personhealth/repositorys/local_data.dart';

Future<bool> changeAvatarPatient(int id, File? image) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var headers = {
      "Authorization": token,
      "content-type": "multipart/form-data"
    };
    String? mimeType = mime(image!.path);
    String mimeT = '';
    String type = '';
    if (mimeType != null) {
      mimeT = mimeType.split('/')[0];
      type = mimeType.split('/')[1];
    }


    var request = new http.MultipartRequest('POST', Uri.parse('$CHANGE_AVATAR_GROUP$id/patient'));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image',image.path, contentType: new MediaType(mimeT, type),));
    request.fields["role"] = "patient";
    request.fields["Id"] = "$id";
    final response = await request.send();
    print(request.url);
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print(exception);
    return false;
  }
}

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
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> parse = jsonDecode(utf8.decode(response.bodyBytes));
      var patient = Patient.fromJson(parse);
      return patient;
    } else {
      return null;
    }
  } catch (exception) {
    print(exception);
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

Future<Patient?> getDataSharingOfPatientWithOtherPatient(int sharingPatientId, int patientId) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = {"sharedPatientId": patientId, "sharingPatientId": sharingPatientId};
    Uri uri = Uri.parse('$GET_DATA_SHARING_OF_PATIENT');
    final response = await http.post(uri, body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    print('$GET_DATA_SHARING_OF_PATIENT');
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

Future<bool> editInformationMedicalPatient(Patient patient, List<String> allergyList, List<String> diseaseList, List<String> surgeryList) async {
  try {

    String? password = await LocalData().getPassword();

    var params = {
      "accountId": patient.accountId,
      "address": patient.address,
      "allergyList": allergyList,
      "bloodType": patient.bloodType,
      "diseaseList": diseaseList,
      "dob": patient.dob,
      "eyesight": patient.eyesight,
      "gender": patient.gender,
      "height": patient.height,
      "image": patient.image,
      "name": patient.name,
      "password": password,
      "surgeryList": surgeryList,
      "weight": patient.weight,
    };

    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.put(
        Uri.parse('$EDIT_PATIENT_INFORMATION$patientId'),
        body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: token
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('edit Patient information error: ' + exception.toString());
    return false;
  }
}

Future<bool> editInformationPatient(Patient patient) async {
  try {
    List<String> diseaseList = [];
    diseaseList = patient.getListDiseases().split(",");

    List<String> surgeryList = [];
    surgeryList = patient.getListSurgeries().split(",");

    List<String> allergyList = [];
    allergyList = patient.getListAllergies().split(",");

    String? password = await LocalData().getPassword();

    var params = {
      "accountId": patient.accountId,
      "address": patient.address,
      "allergyList": allergyList,
      "bloodType": patient.bloodType,
      "diseaseList": diseaseList,
      "dob": patient.dob,
      "eyesight": patient.eyesight,
      "gender": patient.gender,
      "height": patient.height,
      "image": patient.image,
      "name": patient.name,
      "password": password,
      "surgeryList": surgeryList,
      "weight": patient.weight,
    };

    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.put(
        Uri.parse('$EDIT_PATIENT_INFORMATION$patientId'),
        body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "*/*",
      HttpHeaders.authorizationHeader: token
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('edit Patient information error: ' + exception.toString());
    return false;
  }
}

Future<bool?> editPatientInformation(Patient patient) async {
  try {
    int? patientId = await LocalData().getPatientId();
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    var params = patient.toJson();
    final response = await http.put(Uri.parse('$EDIT_PATIENT_INFORMATION$patientId'), body: json.encode(params), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: token
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (exception) {
    print('edit Patient information error: ' + exception.toString());
    return false;
  }
}
