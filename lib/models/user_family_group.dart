class UserFamilyGroup {
  final String avatar;
  final int id;
  final String name, roleInTheGroup, status;

  UserFamilyGroup(this.avatar, this.id, this.name, this.roleInTheGroup, this.status);

  factory UserFamilyGroup.fromJson(dynamic json) {
    String avatarTemp = json['avatar'] == null ? '':json['avatar'];
    return UserFamilyGroup(
        avatarTemp,
        json['id'] as int,
        json['name'] as String,
        json['roleInTheGroup'] as String,
        json['status'] as String);
  }
}