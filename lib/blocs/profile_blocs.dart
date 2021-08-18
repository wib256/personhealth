import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/profile_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/states/profile_states.dart';

class ProfileBloc extends Bloc<ProfileBloc, ProfileState>{
  ProfileBloc():super(ProfileStateInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileBloc event) async* {
    if (event is ProfileFetchEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        Patient? patient = await getPatientByIdFromApi(patientId!);
        if (patient != null) {
          if (patient.status.compareTo('new') == 0) {
            String? name = await LocalData().getName();
            String? phone = await LocalData().getPhone();
            String? gender = await LocalData().getGender();
            String? dob = await LocalData().getDob();
            patient.setName(name!);
            patient.setPhone(phone!);
            patient.setDob(dob!);
            patient.setGender(gender!);
          }
          yield ProfileStateSuccess(patient: patient);
        } else {
          yield ProfileStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield ProfileStateFailure();
      }
    }
    if (event is ProfileUpdateImageEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        bool isChange = await changeAvatarPatient(patientId!,event.image);
        var currentState = state as ProfileStateSuccess;
        if (isChange) {
          Patient? patient = await getPatientByIdFromApi(patientId);
          if (patient != null) {
            await LocalData().saveImage(patient.image);
            yield ProfileStateSuccess(patient: patient);
          } else {
            yield currentState;
          }
        } else {
          yield currentState;
        }
      } catch (exception){
        print('State error: ' + exception.toString());
        var currentState = state as ProfileStateSuccess;
        yield currentState;
      }
    }
    if (event is ProfileUpdateLegalEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        var currentState = state as ProfileStateSuccess;
        Patient patient = currentState.patient;
        if (event.address.compareTo('') != 0) {
          patient.setAddress(event.address);
        }
        if (event.bloodType.compareTo('') != 0) {
          patient.setBloodType(event.bloodType);
        }
        if (event.bloodType.compareTo('') != 0) {
          patient.setDob(event.dob);
        }

        bool isUpdate = await editInformationPatient(patient);
        if (isUpdate) {
          Patient? patient = await getPatientByIdFromApi(patientId!);
          if (patient != null) {
            yield ProfileStateSuccess(patient: patient);
          } else {
            yield currentState;
          }
        } else {
          yield currentState;
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as ProfileStateSuccess;
        yield currentState;
      }
    }
    if (event is ProfileUpdateBodyEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        var currentState = state as ProfileStateSuccess;
        Patient patient = currentState.patient;
        if (event.height.compareTo('') != 0) {
          patient.setHeight(event.height);
        }
        if (event.weight.compareTo('') != 0) {
          patient.setWeight(event.weight);
        }
        if (event.eyesight.compareTo('') != 0) {
          patient.setEyesight(event.eyesight);
        }
        bool isUpdate = await editInformationPatient(patient);
        if (isUpdate) {
          Patient? patient = await getPatientByIdFromApi(patientId!);
          if (patient != null) {
            yield ProfileStateSuccess(patient: patient);
          } else {
            yield currentState;
          }
        } else {
          yield currentState;
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as ProfileStateSuccess;
        yield currentState;
      }
    }
    if (event is ProfileUpdateMedicalEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        var currentState = state as ProfileStateSuccess;
        Patient patient = currentState.patient;
        List<String> allergyList =[];
        List<String> diseaseList = [];
        List<String> surgeryList = [];
        if (event.surgeryList.compareTo('') != 0) {
          surgeryList = event.surgeryList.split(",");
        }
        if (event.diseaseList.compareTo('') != 0) {
          diseaseList = event.diseaseList.split(",");
        }
        if (event.allergyList.compareTo('') != 0) {
          allergyList = event.allergyList.split(",");
        }
        bool isUpdate = await editInformationMedicalPatient(patient, allergyList, diseaseList, surgeryList);
        if (isUpdate) {
          Patient? patient = await getPatientByIdFromApi(patientId!);
          if (patient != null) {
            yield ProfileStateSuccess(patient: patient);
          } else {
            yield currentState;
          }
        } else {
          yield currentState;
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as ProfileStateSuccess;
        yield currentState;
      }
    }
  }
}