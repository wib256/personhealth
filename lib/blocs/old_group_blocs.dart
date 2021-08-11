import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/old_group_event.dart';
import 'package:personhealth/models/group.dart';
import 'package:personhealth/models/shared.dart';
import 'package:personhealth/models/user_family_group.dart';
import 'package:personhealth/repositorys/group_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/repositorys/user_family_group_repository.dart';
import 'package:personhealth/states/old_group_states.dart';

class GroupBloc extends Bloc<GroupBloc, GroupState> {
  GroupBloc() : super(GroupStateInitial());

  @override
  Stream<GroupState> mapEventToState(GroupBloc event) async* {
    if (event is GroupFetchEvent) {
      if (state is GroupStateInitial) {
        var patientId = await LocalData().getPatientId();
        final List<UserFamilyGroup> listGroup = await getListGroup(patientId);
        final List<Sharing> listSharing = await getSharingList();
        final List<Shared> listShared = await getSharedList();
        final List<Group> listInvitedGroup = await getInvitedGroup();
        yield GroupStateSuccess(listGroup: listGroup, listShared: listShared, listSharing: listSharing, listInvitedGroup: listInvitedGroup);
      } else if (state is GroupStateSuccess) {
        var patientId = await LocalData().getPatientId();
        final List<UserFamilyGroup> listGroup = await getListGroup(patientId);
        final List<Sharing> listSharing = await getSharingList();
        final List<Shared> listShared = await getSharedList();
        final List<Group> listInvitedGroup = await getInvitedGroup();
        yield GroupStateSuccess(listGroup: listGroup, listShared: listShared, listSharing: listSharing, listInvitedGroup: listInvitedGroup);
      }
    } else if (event is GroupCreateEvent) {
      if (state is GroupStateSuccess) {
        int? leaderId = await LocalData().getPatientId();
        bool isCreate = await createGroup(event.groupName, leaderId!);
        if (isCreate) {
          final List<UserFamilyGroup> listGroup = await getListGroup(leaderId);
          final List<Sharing> listSharing = await getSharingList();
          final List<Shared> listShared = await getSharedList();
          final List<Group> listInvitedGroup = await getInvitedGroup();
          yield GroupStateSuccess(listGroup: listGroup, listShared: listShared, listSharing: listSharing, listInvitedGroup: listInvitedGroup);
        } else {
          var currentState = state as GroupStateSuccess;
          yield currentState;
        }
      }
    }

    if (event is GroupAcceptEvent) {
      if (state is GroupStateSuccess) {
        var patientId = await LocalData().getPatientId();
        var currentState = state as GroupStateSuccess;
        await acceptInvited(event.familyId, patientId!);
        final List<Group> listInvitedGroup = await getInvitedGroup();
        yield GroupStateSuccess(listGroup: currentState.listGroup, listShared: currentState.listShared, listSharing: currentState.listSharing, listInvitedGroup: listInvitedGroup);
      }
    }

    if (event is PrivateEditEvent) {
      if (state is GroupStateSuccess) {
        var patientId = await LocalData().getPatientId();
        var currentState = state as GroupStateSuccess;
        await editSharingInformationToPatient(
            event.bodyIndex, event.legalInformation,
            event.prehistoricInformation, patientId!);
        yield currentState;
      }
    }
  }
}
