import 'package:personhealth/blocs/group_blocs.dart';

class GroupFetchEvent extends GroupBloc {}

class GroupCreateEvent extends GroupBloc {
  final String groupName;

  GroupCreateEvent({required this.groupName});
}

class GroupAcceptEvent extends GroupBloc {
  final int familyId;

  GroupAcceptEvent({required this.familyId});
}

class PrivateEditEvent extends GroupBloc {
  final int patientId;
  final bool bodyIndex;
  final bool legalInformation;
  final bool prehistoricInformation;
  PrivateEditEvent({required this.patientId, required this.bodyIndex, required this.legalInformation, required this.prehistoricInformation});
}


