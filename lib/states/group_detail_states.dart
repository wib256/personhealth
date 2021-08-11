import 'package:personhealth/models/group_family.dart';
import 'package:personhealth/models/patient.dart';

class GroupDetailState {
  const GroupDetailState();
}

class GroupDetailStateInitial extends GroupDetailState{}
class GroupDetailStateFailure extends GroupDetailState{}
class GroupDetailStateSuccess extends GroupDetailState{
  final GroupFamily groupFamily;
  final List<Patient> patients;
  GroupDetailStateSuccess({required this.groupFamily, required this.patients});
}