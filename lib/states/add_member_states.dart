import 'package:personhealth/models/patient.dart';

class AddMemberState {
  const AddMemberState();
}

class AddMemberStateInitial extends AddMemberState{}
class AddMemberStateFailure extends AddMemberState{}
class AddMemberStateSuccess extends AddMemberState{
  final Patient patient;
  final bool isAdded;
  AddMemberStateSuccess({required this.patient, required this.isAdded});
}