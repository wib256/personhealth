import 'package:personhealth/models/patient.dart';

class GroupFamily {
  String name;
  final String avatar;
  final int leaderId;
  final List<Patient> patients;
  String leaderImage;
  String leaderName;
  String leaderPhone;

  void setName(String newName) {
    name = newName;
  }

  GroupFamily({required this.name, required this.avatar, required this.leaderId, required this.patients, required this.leaderImage, required this.leaderName, required this.leaderPhone});

  factory GroupFamily.fromJson(Map<String, dynamic> json) => GroupFamily(
    name: json["name"] != null ? json["name"] : '',
    avatar: json["avatar"] != null ? json["avatar"] : '',
    leaderId: json["leaderId"],
    patients: List<Patient>.from(json["patients"].map((x) => Patient.fromJson(x))),
    leaderImage: json["leaderImage"] == null ? '' : json["leaderImage"],
    leaderName: json["leaderName"] == null ? '' : json["leaderName"],
    leaderPhone: json["leaderPhone"] == null ? '' : json["leaderPhone"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
    "leaderId": leaderId,
    "patients": List<dynamic>.from(patients.map((x) => x.toJson())),
    "leaderImage": leaderImage,
    "leaderName": leaderName,
    "leaderPhone": leaderPhone
  };
}