import 'package:personhealth/models/disease_health_record.dart';

class Patient {
  int id;
  final int accountId;
  final String medicalNote;
  String image;
  int height;
  int weight;
  int eyesight;
  String name;
  String dob;
  String gender;
  String bloodType;
  String address;
  List<DiseaseHealthRecord> diseaseHealthRecordList;
  String phone;
  final String status;
  final bool hasLegal;
  final bool hasBody;
  final bool hasPreHistoric;

  void setGender(String gender) {
    this.gender = gender;
  }

  void setPhone(String phone) {
    this.phone = phone;
  }

  void setAddress(String address) {
    this.address = address;
  }

  void setBloodType(String bloodType) {
    this.bloodType = bloodType;
  }

  void setDob(String dob) {
    this.dob = dob;
  }

  void setName(String name) {
    this.name = name;
  }

  void setEyesight(String eyesight) {
    this.eyesight = int.parse(eyesight);
  }

  void setHeight(String height) {
    this.height = int.parse(height);
  }

  void setWeight(String weight) {
    this.weight = int.parse(weight);
  }

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
        diseaseHealthRecordList: json["diseaseHealthRecordList"] != null ? List<DiseaseHealthRecord>.from(
            json["diseaseHealthRecordList"]
                .map((x) => DiseaseHealthRecord.fromJson(x))) : [],
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

  String getListDiseases() {
    String result = '';
    for (int i = 0; i < diseaseHealthRecordList.length; i++) {
      if (diseaseHealthRecordList[i].description.compareTo('Benh') == 0) {
        if (result.compareTo('') == 0) {
          result = diseaseHealthRecordList[i].name;
        } else {
          result = result + ', ' + diseaseHealthRecordList[i].name;
        }
      }
    }
    if (result.compareTo('') != 00) {
      return result;
    } else {
      return '---';
    }
  }

  String getListAllergies() {
    String result = '';
    for (int i = 0; i < diseaseHealthRecordList.length; i++) {
      if (diseaseHealthRecordList[i].description.compareTo('Di Ung') == 0) {
        if (result.compareTo('') == 0) {
          result = diseaseHealthRecordList[i].name;
        } else {
          result = result + ', ' + diseaseHealthRecordList[i].name;
        }
      }
    }
    if (result.compareTo('') != 00) {
      return result;
    } else {
      return '---';
    }
  }

  String getListSurgeries() {
    String result = '';
    for (int i = 0; i < diseaseHealthRecordList.length; i++) {
      if (diseaseHealthRecordList[i].description.compareTo('Phau Thuat') == 0) {
        if (result.compareTo('') == 0) {
          result = diseaseHealthRecordList[i].name;
        } else {
          result = result + ', ' + diseaseHealthRecordList[i].name;
        }
      }
    }
    if (result.compareTo('') != 00) {
      return result;
    } else {
      return '---';
    }
  }

  @override
  String toString() {
    if (diseaseHealthRecordList.isNotEmpty) {
      List<String> diseases = [];
      List<String> allergies = [];
      List<String> surgeries = [];
      for (int i = 0; i < diseaseHealthRecordList.length; i++) {
        if (diseaseHealthRecordList[i].description.compareTo('Benh') == 0) {
          diseases.add(diseaseHealthRecordList[i].description);
        } else if (diseaseHealthRecordList[i].description.compareTo('Di Ung') ==
            0) {
          allergies.add(diseaseHealthRecordList[i].description);
        } else {
          surgeries.add(diseaseHealthRecordList[i].description);
        }
      }
      return '';
    } else
      return '';
  }
}
