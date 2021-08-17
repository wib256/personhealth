import 'package:personhealth/blocs/add_member_blocs.dart';

class AddMemberFetchEvent extends AddMemberBloc{}
class AddMemberSearchEvent extends AddMemberBloc{
  final String phone;
  AddMemberSearchEvent({required this.phone});
}

class AddMemberAddEvent extends AddMemberBloc{
  final String phone;
  final int familyId;
  AddMemberAddEvent({required this.phone, required this.familyId});
}

class AddMemberShareEvent extends AddMemberBloc {
  final bool legalInformation;
  final bool bodyIndex;
  final bool prehistoricInformation;
  final String phone;
  AddMemberShareEvent({required this.phone, required this.prehistoricInformation, required this.legalInformation, required this.bodyIndex});
}