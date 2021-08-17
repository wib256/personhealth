import 'dart:io' as local;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/group_detail_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/group_family_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/group_detail_states.dart';

class GroupDetailBloc extends Bloc<GroupDetailBloc, GroupDetailState>{
  GroupDetailBloc():super(GroupDetailStateInitial());

  @override
  Stream<GroupDetailState> mapEventToState(GroupDetailBloc event) async* {
    if (event is GroupDetailFetchEvent) {
      try {
        int familyId = event.familyId;
        final groupFamily = await getGroupFamilyDetailFromApi(familyId);
        Patient? leader = await getDataSharingOfPatient(familyId, groupFamily!.leaderId);
        if (groupFamily.patients.length > 0) {
          List<Patient> patients = [];
          for (int i = 0; i < groupFamily.patients.length; i++) {
            Patient? patient = await getDataSharingOfPatient(familyId, groupFamily.patients[i].id);
            if (patient != null) {
              patient.setId(groupFamily.patients[i].id);
              patient.setName(groupFamily.patients[i].name);
              patient.setPhone(groupFamily.patients[i].phone);
              patient.setImage(groupFamily.patients[i].image);
              patients.add(patient);
            } else {
              patient = new Patient(id: groupFamily.patients[i].id, accountId: 0, medicalNote: "", image: groupFamily.patients[i].image, height: 0, weight: 0, eyesight: 0, name: groupFamily.patients[i].name, dob: 'dob', gender: 'gender', bloodType: 'bloodType', address: 'address', diseaseHealthRecordList: List.empty(), phone: 'phone', status: 'status', hasLegal: false, hasBody: false, hasPreHistoric: false);
              patients.add(patient);
            }
          }
          if (leader != null) {
            leader.setId(groupFamily.leaderId);
            leader.setName(groupFamily.leaderName);
            leader.setPhone(groupFamily.leaderPhone);
            leader.setImage(groupFamily.leaderImage);
            groupFamily.patients.insert(0, leader);
            patients.insert(0, leader);
          }

          yield GroupDetailStateSuccess(groupFamily: groupFamily, patients: patients, isEdited: false, isRename: false, isChangeAvatar: false);
        } else {
          yield GroupDetailStateFailure();
        }
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupDetailStateFailure();
      }
    }

    if (event is GroupDetailEditEvent) {
      try {
        var currentState = state as GroupDetailStateSuccess;
        bool post = await postSharingInformationToGroup(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.familyGroupId);
        if (!post) {
          bool isEdited = await editSharingInformationToGroup(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.familyGroupId);
          if (isEdited) {
            int? patientId = await LocalData().getPatientId();
            Patient? patient = await getDataSharingOfPatient(event.familyGroupId, patientId!);
            if (patient != null) {
              for (int i = 0; i < currentState.patients.length; i++) {
                if (currentState.patients[i].id == patientId) {
                  patient.setId(currentState.groupFamily.patients[i].id);
                  patient.setName(currentState.patients[i].name);
                  patient.setPhone(currentState.patients[i].phone);
                  patient.setImage(currentState.patients[i].image);
                  currentState.patients[i] = patient;
                }
              }
            }
            yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: true, isRename: false, isChangeAvatar: false);
          } else {
            yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: false, isRename: false, isChangeAvatar: false);
          }
        } else {
          yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: true, isRename: false, isChangeAvatar: false);
        }
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupDetailStateFailure();
      }
    }
    if (event is GroupDetailRenameEvent) {
      try {
        var currentState = state as GroupDetailStateSuccess;
        bool isRename = await renameGroup(event.familyInt, event.groupName);
        if (isRename) {
          currentState.groupFamily.setName(event.groupName);
          yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: false, isRename: true, isChangeAvatar: false);
        } else {
          yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: false, isRename: false, isChangeAvatar: false);
        }
      }catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupDetailStateFailure();
      }
    }

    if (event is GroupDetailChangeAvatarEvent) {
      try {
        var currentState = state as GroupDetailStateSuccess;
        bool isChange = await changeAvatar(event.familyId, event.image as local.File);
        if (isChange) {
          yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: false, isRename: false, isChangeAvatar: true);
        } else {
          yield GroupDetailStateSuccess(groupFamily: currentState.groupFamily, patients: currentState.patients, isEdited: false, isRename: false, isChangeAvatar: false);
        }
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupDetailStateFailure();
      }
    }
  }
}