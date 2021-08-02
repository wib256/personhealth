import 'package:personhealth/models/disease_health_record.dart';

class Patient {
  int id;
  final int accountId;
  final String medicalNote;
  String image;
  final int height;
  final int weight;
  final int eyesight;
  final String name;
  final String dob;
  final String gender;
  final String bloodType;
  final String address;
  List<DiseaseHealthRecord> diseaseHealthRecordList;
  final String phone;
  final String status;
  final bool hasLegal;
  final bool hasBody;
  final bool hasPreHistoric;

  void setImage(String newImage) {
    image = newImage;
  }

  Patient(
      {required this.id,
      required this.accountId,
      required this.medicalNote,
      required this.image,
      required this.height,
      required this.weight,
      required this.eyesight,
      required this.name,
      required this.dob,
      required this.gender,
      required this.bloodType,
      required this.address,
      required this.diseaseHealthRecordList,
      required this.phone,
      required this.status,
      required this.hasLegal,
      required this.hasBody,
      required this.hasPreHistoric});

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"] != null ? json["id"] : 0,
        accountId: json["accountId"] != null ? json["accountId"] : 0,
        medicalNote: json['medicalNote'] == null ? '' : json['medicalNote'],
        image: json['image'] == null ? '' : json['image'],
        height: json['height'] == null ? 0 : json['height'],
        weight: json['weight'] == null ? 0 : json['weight'],
        eyesight: json['eyesight'] == null ? 0 : json['eyesight'],
        name: json['name'] == null ? '' : json['name'],
        dob: json['dob'] == null ? '' : json['dob'],
        gender: json['gender'] == null ? '' : json['gender'],
        bloodType: json['bloodType'] == null ? '' : json['bloodType'],
        address: json['address'] == null ? '' : json['address'],
        diseaseHealthRecordList: List<DiseaseHealthRecord>.from(
                    json["diseaseHealthRecordList"]
                        .map((x) => DiseaseHealthRecord.fromJson(x))) !=
                null
            ? List<DiseaseHealthRecord>.from(json["diseaseHealthRecordList"]
                .map((x) => DiseaseHealthRecord.fromJson(x)))
            : List.empty(),
        phone: json['phone'] == null ? '' : json['phone'],
        status: json['status'] == null ? '' : json['status'],
        hasLegal: json['haslegal'] == null ? false : json['haslegal'],
        hasBody: json['hasbody'] == null ? false : json['hasbody'],
        hasPreHistoric:
            json['hasprehistoric'] == null ? false : json['hasprehistoric'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountId": accountId,
        "medicalNote": medicalNote,
        "image": image,
        "height": height,
        "weight": weight,
        "eyesight": eyesight,
        "name": name,
        "dob": dob,
        "gender": gender,
        "bloodType": bloodType,
        "address": address,
        "diseaseHealthRecordList":
            List<dynamic>.from(diseaseHealthRecordList.map((x) => x.toJson())),
        "phone": phone,
        "status": status,
        "haslegal": hasLegal,
        "hasbody": hasBody,
        "hasprehistoric": hasPreHistoric
      };

  void setId(int patientId) {
    if (id == 0) {
      id = patientId;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return diseaseHealthRecordList.isNotEmpty ? diseaseHealthRecordList.toString() : 'None';
  }

// factory Patient.fromJson(dynamic json) {
//   String medicalNoteT = json['medicalNote'] == null ? '' : json['medicalNote'];
//   String imageT = json['image'] == null ? '' : json['image'];
//   int heightT = json['height'] == null ? '' : json['height'];
//   int weightT = json['weight'] == null ? '' : json['weight'];
//   int eyesightT = json['eyesight'] == null ? '' : json['eyesight'];
//   String nameT = json['name'] == null ? '' : json['name'];
//   String doBT = json['dob'] == null ? '' : json['dob'];
//   String genderT = json['gender'] == null ? '' : json['gender'];
//   String bloodTypeT = json['bloodType'] == null ? '' : json['bloodType'];
//   String addressT = json['address'] == null ? '' : json['address'];
//   String phone = json['phone'] == null ? '' : json['phone'];
//   String status = json['status'] == null ? '' : json['status'];
//   List<DiseaseHealthRecord> diseaseHealthRecordList = json['diseaseHealthRecordList'] != null ? json.map<DiseaseHealthRecord>((json) => DiseaseHealthRecord.fromJson(json)).toList() : List.empty();
//   return Patient(
//       json['id'] as int,
//       json['accountId'] as int,
//       medicalNoteT,
//       imageT,
//       heightT,
//       weightT,
//       eyesightT,
//       nameT,
//       doBT,
//       genderT,
//       bloodTypeT,
//       addressT,
//       diseaseHealthRecordList,
//       phone,
//       status);
// }
}
