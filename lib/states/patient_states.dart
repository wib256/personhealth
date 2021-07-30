import 'package:personhealth/models/patient.dart';

class PatientState {
  const PatientState();
}

class PatientStateInitial extends PatientState {}
class PatientStateFailure extends PatientState {}
class PatientStateSuccess extends PatientState {
  final Patient patient;
  const PatientStateSuccess({required this.patient});
}