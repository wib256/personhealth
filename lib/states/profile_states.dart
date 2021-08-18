import 'package:personhealth/models/patient.dart';

class ProfileState {
  const ProfileState();
}

class ProfileStateInitial extends ProfileState {}
class ProfileStateFailure extends ProfileState {}
class ProfileStateSuccess extends ProfileState {
  final Patient patient;
  ProfileStateSuccess({required this.patient});
}