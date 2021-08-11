import 'package:personhealth/models/user_family_group.dart';

class GroupState {
  const GroupState();
}

class GroupStateInitial extends GroupState {}
class GroupStateFailure extends GroupState {}
class GroupStateSuccess extends GroupState {
  final List<UserFamilyGroup> listGroup;
  final bool isCreated;
  GroupStateSuccess({required this.listGroup, required this.isCreated});
}