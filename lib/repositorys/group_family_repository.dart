import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:personhealth/constants/constant.dart';
import 'package:personhealth/models/group_family.dart';
import 'package:http_parser/http_parser.dart';
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

Future<bool> renameGroup(int familyId, String name) async {
  try {
    String? token = await LocalData().getToken();
    token = 'Bearer ' + token!;
    final response = await http.put(Uri.parse('$RENAME_GROUP$familyId/$name'), headers: {
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

Future<bool> changeAvatar(int familyId, File? image) async {
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


    var request = new http.MultipartRequest('POST', Uri.parse('$CHANGE_AVATAR_GROUP$familyId/group'));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image',image.path, contentType: new MediaType(mimeT, type),));
    request.fields["role"] = "group";
    request.fields["Id"] = "$familyId";
    print(request.url);
    print(image.path);
    print(request.fields);
    print(request.files.length);
    print(request.method);
    final response = await request.send();
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

