
class Clinic {
  final String address;
  final int clinicGroupId;
  final String coordinate;
  final String description;
  final String district;
  final int id;
  final String image;
  final String name;
  final String phone;
  final String status;

  Clinic(this.address, this.clinicGroupId, this.coordinate, this.description, this.district, this.id, this.image, this.name, this.phone, this.status);

  factory Clinic.fromJson(dynamic json) {
    int clinicGroupIdTemp = json['clinicGroupId'] == null ? 0:json['clinicGroupId'];
    String img = json['image'] == null ? '' : json['image'];
    return Clinic(
        json['address'] as String,
        clinicGroupIdTemp,
        json['coordinate'] as String,
        json['description'] as String,
        json['district'] as String,
        json['id'] as int,
        img,
        json['name'] as String,
        json['phone'] as String,
        json['status'] as String);
  }
}