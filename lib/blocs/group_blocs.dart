import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/models/group.dart';
import 'package:personhealth/models/user_family_group.dart';
import 'package:personhealth/repositorys/group_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/user_family_group_repository.dart';
import 'package:personhealth/states/group_states.dart';

class GroupBloc extends Bloc<GroupBloc, GroupState> {
  GroupBloc():super(GroupStateInitial());

  @override
  Stream<GroupState> mapEventToState(GroupBloc event) async* {
    if (event is GroupFetchEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        List<UserFamilyGroup> listGroup = await getListGroup(patientId);
        yield GroupStateSuccess(listGroup: listGroup, isCreated: false);
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupStateFailure();
      }
    }
    if (event is GroupCreateEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        bool isCreate = await createGroup(event.groupName, patientId!);
        if (isCreate) {
          List<UserFamilyGroup> listGroup = await getListGroup(patientId);
          yield GroupStateSuccess(listGroup: listGroup, isCreated: true);
        } else {
          var currentState = state as GroupStateSuccess;
          yield currentState;
        }
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupStateFailure();
      }
    }
  }
}