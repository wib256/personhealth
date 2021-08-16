class DiseaseHealthRecord {
  int id;
  int patientId;
  String name;
  String description;

  DiseaseHealthRecord({
    required this.id,
    required this.patientId,
    required this.name,
    required this.description,
  });
  factory DiseaseHealthRecord.fromJson(Map<String, dynamic> json) => DiseaseHealthRecord(
    id: json["id"],
    patientId: json["patientId"],
    name: json["name"] != null ? json["name"] : '',
    description: json["description"] != null ? json["description"] : '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "patientId": patientId,
    "name": name,
    "description": description,
  };

  @override
  String toString() {
    return name;
  }
}