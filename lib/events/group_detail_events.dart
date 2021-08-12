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