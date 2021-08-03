import 'package:personhealth/blocs/patient_blocs.dart';
import 'dart:io';

import 'package:personhealth/models/patient.dart';

class PatientFetchEvent extends PatientBloc {}
class PatientSearchEvent extends PatientBloc {
  final String phone;

  PatientSearchEvent({required this.phone});
}

class PatientViewEvent extends PatientBloc{}

class PatientSharingEvent extends PatientBloc {
  final bool bodyIndex, legalInformation, prehistoricInformation;
  final String phoneOfSharedPatient;

  PatientSharingEvent({required this.bodyIndex, required this.legalInformation, required this.prehistoricInformation, required this.phoneOfSharedPatient});

}

class PatientEditAvatarEvent extends PatientBloc {
  final File? image;
   PatientEditAvatarEvent({required this.image});
}

class PatientShowInformationEvent extends PatientBloc {
  final int sharingPatientId;
  PatientShowInformationEvent({required this.sharingPatientId});
}

class PatientEditInformationEvent extends PatientBloc {
  final Patient patient;
  PatientEditInformationEvent({required this.patient});
}