import 'package:personhealth/blocs/group_detail_blocs.dart';

class GroupDetailFetchEvent extends GroupDetailBloc{
  final int familyId;
  GroupDetailFetchEvent({required this.familyId});
}