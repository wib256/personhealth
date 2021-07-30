class Shared {
  final int id;
  final String image, name;

  Shared({required this.id, required this.image, required this.name});

  factory Shared.fromJson(Map<String, dynamic> json) => Shared(
    id: json["id"],
    image: json["image"] != null ? json["image"] : '',
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
  };
}

class Sharing {
  final int id;
  final String image, name;

  Sharing({required this.id, required this.image, required this.name});

  factory Sharing.fromJson(Map<String, dynamic> json) => Sharing(
    id: json["id"],
    image: json["image"] != null ? json["image"] : '',
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
  };
}