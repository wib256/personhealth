import 'dart:io';
import 'package:personhealth/blocs/profile_blocs.dart';
import 'package:personhealth/models/patient.dart';

class ProfileFetchEvent extends ProfileBloc{}

class ProfileUpdateEvent extends ProfileBloc{
  final Patient patient;
  ProfileUpdateEvent({required this.patient});
}

class ProfileUpdateImageEvent extends ProfileBloc{
  final File? image;
  ProfileUpdateImageEvent({required this.image});
}

class ProfileUpdateLegalEvent extends ProfileBloc{
  final String address;
  final String bloodType;
  final String dob;
  ProfileUpdateLegalEvent({required this.address, required this.bloodType, required this.dob});
}

class ProfileUpdateBodyEvent extends ProfileBloc{
  final String height;
  final String weight;
  final String eyesight;
  ProfileUpdateBodyEvent({required this.height, required this.weight, required this.eyesight});
}

class ProfileUpdateMedicalEvent extends ProfileBloc{
  final String diseaseList;
  final String surgeryList;
  final String allergyList;
  ProfileUpdateMedicalEvent({required this.diseaseList, required this.surgeryList, required this.allergyList});
}