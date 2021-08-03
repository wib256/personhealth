import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/patient_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/patient_states.dart';

class PatientBloc extends Bloc<PatientBloc, PatientState> {
  PatientBloc() : super(PatientStateInitial());

  @override
  Stream<PatientState> mapEventToState(PatientBloc event) async* {
    // TODO: implement mapEventToState
    if (event is PatientFetchEvent) {
      yield PatientStateSuccess(patient: new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: '', status: '', hasLegal: false, hasBody: false,  hasPreHistoric: false));
    } else if (event is PatientSearchEvent) {
      String phone = event.phone;
      if (state is PatientStateInitial) {
        yield PatientStateSuccess(patient: new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: phone, status: '', hasLegal: false, hasBody: false,  hasPreHistoric: false));
      } else if (state is PatientStateSuccess) {
        Patient? patient = await getPatientByPhoneFromApi(phone);
        if (patient != null) {
          yield PatientStateSuccess(patient: patient);
        } else {
          yield PatientStateSuccess(patient: new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: phone, status: '', hasLegal: false, hasBody: false,  hasPreHistoric: false));
        }
      } else {
        yield PatientStateFailure();
      }
    } else if (event is PatientViewEvent) {
      int? patientId = await LocalData().getPatientId();
      Patient? patient = await getPatientByIdFromApi(patientId!);
      if (patient != null) {
        yield PatientStateSuccess(patient: patient);
      } else {
        yield PatientStateSuccess(patient: new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: '', status: '', hasLegal: false, hasBody: false,  hasPreHistoric: false));
      }
    } else if (event is PatientSharingEvent) {
      await postSharingInformationToPatient(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.phoneOfSharedPatient);
      yield PatientStateInitial();
    } else if (event is PatientEditAvatarEvent) {
      int? patientId = await LocalData().getPatientId();
      bool isChange = await changeAvatarPatient(patientId!,event.image);
      if (isChange) {
        final patient = await getPatientByIdFromApi(patientId);
        if (patient != null) {
          await LocalData().saveImage(patient.image);
          yield PatientStateSuccess(patient: patient);
        } else {
          print('Get patient ko thanh cong');
          yield PatientStateFailure();
        }
      } else {
        print('Change avatar khong thanh cong');
        yield PatientStateFailure();
      }
    } else if (event is PatientShowInformationEvent) {
      int? sharedPatientId = await LocalData().getPatientId();
      Patient? patient = await getDataSharingOfPatientWithOtherPatient(event.sharingPatientId, sharedPatientId!);
      if (patient != null) {
        print('Patient da khac null');
        yield PatientStateSuccess(patient: patient);
      } else {
        yield PatientStateSuccess(patient: Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: '', status: '', hasLegal: false, hasBody: false,  hasPreHistoric: false));
      }
    } else {
      yield PatientStateFailure();
    }
  }
}
