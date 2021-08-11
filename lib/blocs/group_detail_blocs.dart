import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/group_detail_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/group_family_repository.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/states/group_detail_states.dart';

class GroupDetailBloc extends Bloc<GroupDetailBloc, GroupDetailState>{
  GroupDetailBloc():super(GroupDetailStateInitial());

  @override
  Stream<GroupDetailState> mapEventToState(GroupDetailBloc event) async* {
    if (event is GroupDetailFetchEvent) {
      try {
        int familyId = event.familyId;
        final groupFamily = await getGroupFamilyDetailFromApi(familyId);
        if (groupFamily != null) {
          List<Patient> patients = [];
          for (int i = 0; i < groupFamily.patients.length; i++) {
            Patient? patient = await getDataSharingOfPatient(familyId, groupFamily.patients[i].id);
            if (patient != null) {
              patient.setId(groupFamily.patients[i].id);
              patient.setName(groupFamily.patients[i].name);
              patient.setPhone(groupFamily.patients[i].phone);
            }
          }
          yield GroupDetailStateSuccess(groupFamily: groupFamily, patients: patients);
        } else {
          yield GroupDetailStateFailure();
        }
      } catch (exception) {
        print('State exception: ' + exception.toString());
        yield GroupDetailStateFailure();
      }
    }
  }
}