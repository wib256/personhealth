class DiseaseHealthRecord {
  int id;
  String name;
  String description;
  String status;

  DiseaseHealthRecord({required this.id, required this.description, required this.name, required this.status});

  factory DiseaseHealthRecord.fromJson(Map<String, dynamic> json) => DiseaseHealthRecord(
    id: json["id"],
    name: json["name"] != null ? json["name"] : '',
    description: json["description"] != null ? json["description"] : '',
    status: json["status"] != null ? json["status"] : '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
  };

  @override
  String toString() {
    // TODO: implement toString
    return name;
  }
}