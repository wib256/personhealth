import 'package:personhealth/blocs/group_blocs.dart';

class GroupFetchEvent extends GroupBloc{}

class GroupCreateEvent extends GroupBloc{
  final String groupName;
  GroupCreateEvent({required this.groupName});
}