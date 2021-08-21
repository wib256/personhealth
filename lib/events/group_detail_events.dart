import 'dart:io';
import 'package:personhealth/blocs/group_detail_blocs.dart';

class GroupDetailFetchEvent extends GroupDetailBloc{
  final int familyId;
  GroupDetailFetchEvent({required this.familyId});
}

class GroupDetailEditEvent extends GroupDetailBloc {
  final int familyGroupId;
  final bool bodyIndex;
  final bool legalInformation;
  final bool prehistoricInformation;

  GroupDetailEditEvent({required this.familyGroupId, required this.bodyIndex, required this.legalInformation, required this.prehistoricInformation});
}

class GroupDetailRenameEvent extends GroupDetailBloc {
  final int familyInt;
  final String groupName;
  GroupDetailRenameEvent({required this.familyInt,required this.groupName});
}

class GroupDetailChangeAvatarEvent extends GroupDetailBloc {
  final int familyId;
  final File? image;

  GroupDetailChangeAvatarEvent({required this.familyId, required this.image});
}

class GroupDetailRemoveMemberEvent extends GroupDetailBloc {
  final int familyId;
  final int patientId;
  GroupDetailRemoveMemberEvent({required this.familyId, required this.patientId});
}