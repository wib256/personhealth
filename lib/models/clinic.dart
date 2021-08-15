
class Clinic {
  final String address;
  final String description;
  final String district;
  final int id;
  final String image;
  final String name;
  final String phone;
  final String status;

  Clinic(this.address, this.description, this.district, this.id, this.image, this.name, this.phone, this.status);

  factory Clinic.fromJson(dynamic json) {
    String img = json['image'] == null ? '' : json['image'];
    return Clinic(
        json['address'] as String,
        json['description'] as String,
        json['district'] as String,
        json['id'] as int,
        img,
        json['name'] as String,
        json['phone'] as String,
        json['status'] as String);
  }
}