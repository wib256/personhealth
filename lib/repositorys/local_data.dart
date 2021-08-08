import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<bool?> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('isLogin');
  }

  Future<void> setIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLogin', true);
  }

  Future<void> saveDob(String dob) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('dob', dob);
  }

  Future<String?> getDob() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('dob');
  }

  Future<void> saveImage(String image) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('image', image);
  }

  Future<String?> getImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('image');
  }

  Future<void> saveName(String name) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('name', name);
  }

  Future<String?> getName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('name');
  }

  Future<void> saveToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('token');
  }

  Future<void> savePhone(String phone) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('phone', phone);
  }

  Future<String?> getPhone() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('phone');
  }

  Future<void> saveGender(String gender) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('gender', gender);
  }

  Future<String?> getGender() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('gender');
  }

  Future<void> savePatientId(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('patientId', id);
  }

  Future<int?> getPatientId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt('patientId');
  }

  Future<void> logOut() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}