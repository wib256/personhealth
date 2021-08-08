class Comment {
  String comment;
  int id;
  String image;
  String name;
  double rate;
  String time;

  Comment({
    required this.comment,
    required this.id,
    required this.image,
    required this.name,
    required this.rate,
    required this.time,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    comment: json["comment"] == null ? '' : json["comment"],
    id: json["id"],
    image: json["image"] == null ? '' : json["image"],
    name: json["name"] == null ? '' : json["name"],
    rate: json["rate"] == null ? 0 : json["rate"],
    time: json["time"] == null ? '' : json["time"]
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "id": id,
    "image": image,
    "name": name,
    "rate": rate,
    "time": time,
  };
}