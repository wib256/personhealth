import 'package:personhealth/models/group.dart';
import 'package:personhealth/models/shared.dart';
import 'package:personhealth/models/user_family_group.dart';

class GroupState {
  const GroupState();
}

class GroupStateInitial extends GroupState {}
class GroupStateFailure extends GroupState {}
class GroupStateSuccess extends GroupState {
  final List<UserFamilyGroup> listGroup;
  final List<Shared> listShared;
  final List<Sharing> listSharing;
  final List<Group> listInvitedGroup;

  const GroupStateSuccess({required this.listGroup, required this.listShared, required this.listSharing, required this.listInvitedGroup});
}