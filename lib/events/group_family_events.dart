import 'dart:io';
import 'package:personhealth/blocs/group_family_blocs.dart';

class GroupFamilyFetchEvent extends GroupFamilyBloc {
  final int familyId;

  GroupFamilyFetchEvent({required this.familyId});
}

class GroupFamilyDetailPatientEvent extends GroupFamilyBloc {
  final int familyId;
  final int patientId;
  final int index;

  GroupFamilyDetailPatientEvent({required this.patientId, required this.familyId, required this.index});
}

class GroupFamilyEditSharingToGroupEvent extends GroupFamilyBloc {
  final int familyGroupId;
  final bool bodyIndex;
  final bool legalInformation;
  final bool prehistoricInformation;

  GroupFamilyEditSharingToGroupEvent({required this.familyGroupId, required this.bodyIndex, required this.legalInformation, required this.prehistoricInformation});
}

class GroupFamilyAddMemberToGroup extends GroupFamilyBloc {
  final int familyGroupId;
  final String phone;

  GroupFamilyAddMemberToGroup({required this.familyGroupId, required this.phone});
}

class GroupFamilyDeleteMember extends GroupFamilyBloc {
  final int familyId;
  final int patientId;
  final int index;

  GroupFamilyDeleteMember({required this.familyId, required this.patientId, required this.index});
}

class GroupFamilyRename extends GroupFamilyBloc {
  final int familyId;
  final String name;

  GroupFamilyRename({required this.familyId, required this.name});
}

class GroupFamilyChangeImage extends GroupFamilyBloc {
  final int familyId;
  final File? image;

  GroupFamilyChangeImage({required this.familyId, required this.image});
}
