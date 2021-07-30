class Group {
  final String avatar;
  final int id, leaderId;
  final String leaderName, name, status;

  Group({required this.avatar, required this.id,required this.leaderId,required this.leaderName,required this.name,required this.status,});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    avatar: json["avatar"] != null ? json["avatar"] : '',
    id: json["id"] != null ? json["id"] : 0,
    leaderId: json["leaderId"] != null ? json["leaderId"] : 0,
    leaderName: json["leaderName"] != null ? json["leaderName"] : '',
    name: json["name"] != null ? json["name"] : '',
    status: json["status"] != null ? json["status"] : '',
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "id": id,
    "leaderId": leaderId,
    "leaderName": leaderName,
    "name": name,
    "status": status,
  };
}