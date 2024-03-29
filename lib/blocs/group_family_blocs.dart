import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/group_family_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/group_family_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/notification.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/group_family_states.dart';
import 'dart:io' as local;

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
        var receiver = await getPatientByPhoneFromApi(event.phone);
        String? name = await LocalData().getName();
        int receiverAccountId = receiver!.accountId;

        await addMember(event.familyGroupId, event.phone);

        String message = name! + " had added you to group ${event.groupName}";
        await sentNotification(receiverAccountId, message);
        yield currentState;
      }
    }
    if (event is GroupFamilyDeleteMember) {
      if (state is GroupFamilyStateSuccess) {
        var currentState = state as GroupFamilyStateSuccess;
        bool isDelete = await removeMember(event.familyId, event.patientId);
        if (isDelete) {
          currentState.groupFamily!.patients.removeAt(event.index);
          currentState.listPatient.removeAt(event.index);
          yield currentState;
        } else {
          yield GroupFamilyStateFailure();
        }
      }
    }
    if (event is GroupFamilyRename) {
      if (state is GroupFamilyStateSuccess) {
        var currentState = state as GroupFamilyStateSuccess;
        bool isRename = await renameGroup(event.familyId, event.name);
        if (isRename) {
          currentState.groupFamily!.setName(event.name);
          yield currentState;
        } else {
          yield GroupFamilyStateFailure();
        }
      }
    }
    if (event is GroupFamilyChangeImage) {
      if (state is GroupFamilyStateSuccess) {
        var currentState = state as GroupFamilyStateSuccess;
        bool isChange = await changeAvatar(event.familyId, event.image as local.File);
        if (isChange) {
          yield currentState;
        } else {
          yield GroupFamilyStateFailure();
        }
      }
    }
  }
}