import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/group_family_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/group_family_repository.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/group_family_states.dart';

class GroupFamilyBloc extends Bloc<GroupFamilyBloc, GroupFamilyState> {
  GroupFamilyBloc():super(GroupFamilyStateInitial());

  @override
  Stream<GroupFamilyState> mapEventToState(GroupFamilyBloc event) async* {
    if (event is GroupFamilyFetchEvent) {
      if (state is GroupFamilyStateInitial) {
        int familyId = event.familyId;
        final groupFamily = await getGroupFamilyDetailFromApi(familyId);
        if (groupFamily != null) {
          List<Patient> patients = [];
          for (int i = 0; i < groupFamily.patients.length; i++) {
            Patient? patient = await getDataSharingOfPatient(familyId, groupFamily.patients[i].id);
            if (patient != null) {
              patients.add(patient);
            } else {
              patients.add(new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: '', status: '', hasLegal: false, hasBody: false, hasPreHistoric: false));
            }
          }
          yield GroupFamilyStateSuccess(groupFamily: groupFamily, listPatient: patients);
        }
      } else if (state is GroupFamilyStateSuccess) {
        int familyId = event.familyId;
        final groupFamily = await getGroupFamilyDetailFromApi(familyId);
        if (groupFamily != null) {
          List<Patient> patients = [];
          for (int i = 0; i < groupFamily.patients.length; i++) {
            Patient? patient = await getDataSharingOfPatient(familyId, groupFamily.patients[i].id);
            if (patient != null) {
              patients.add(patient);
            } else {
              patients.add(new Patient(id: 0, accountId: 0, medicalNote: '', image: '', height: 0, weight: 0, eyesight: 0, name: '', dob: '', gender: '', bloodType: '', address: '', diseaseHealthRecordList: List.empty(), phone: '', status: '', hasLegal: false, hasBody: false, hasPreHistoric: false));
            }
          }
          yield GroupFamilyStateSuccess(groupFamily: groupFamily, listPatient: patients);
        }
      } else {
        yield GroupFamilyStateFailure();
      }
    }
    if (event is GroupFamilyDetailPatientEvent) {
      if (state is GroupFamilyStateSuccess) {
        int familyId = event.familyId;
        int patientId = event.patientId;
        final currentState = state as GroupFamilyStateSuccess;
        final groupFamily = currentState.groupFamily;
        Patient? patient = await getDataSharingOfPatient(familyId, patientId);
        if (patient != null) {
          List<Patient> listPatient = currentState.listPatient;
          listPatient.add(patient);
          yield GroupFamilyStateSuccess(groupFamily: groupFamily, listPatient: listPatient);
        } else {
          yield GroupFamilyStateSuccess(groupFamily: groupFamily, listPatient: List.empty());
        }
      }
    }
    if (event is GroupFamilyEditSharingToGroupEvent) {
      if (state is GroupFamilyStateSuccess) {
        var currentState = state as GroupFamilyStateSuccess;
        bool post = await postSharingInformationToGroup(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.familyGroupId);
        if (!post) {
          await editSharingInformationToGroup(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.familyGroupId);
        }
        yield currentState;
      }
    }
    if (event is GroupFamilyAddMemberToGroup) {
      if (state is GroupFamilyStateSuccess) {
        var currentState = state as GroupFamilyStateSuccess;
        await addMember(event.familyGroupId, event.phone);
        yield currentState;
      }
    }
  }
}