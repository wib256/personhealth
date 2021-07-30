import 'package:personhealth/models/group_family.dart';
import 'package:personhealth/models/patient.dart';

class GroupFamilyState {
  const GroupFamilyState();
}

class GroupFamilyStateInitial extends GroupFamilyState {}
class GroupFamilyStateFailure extends GroupFamilyState {}
class GroupFamilyStateSuccess extends GroupFamilyState {
  final GroupFamily? groupFamily;
  final List<Patient> listPatient;

  const GroupFamilyStateSuccess({required this.groupFamily, required this.listPatient});
}