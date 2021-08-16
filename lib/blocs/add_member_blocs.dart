import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/add_member_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/add_member_states.dart';

class AddMemberBloc extends Bloc<AddMemberBloc, AddMemberState>{
  AddMemberBloc():super(AddMemberStateInitial());

  @override
  Stream<AddMemberState> mapEventToState(AddMemberBloc event) async* {
    if (event is AddMemberFetchEvent) {
      yield AddMemberStateFailure();
    }
    if (event is AddMemberSearchEvent) {
      try {
        Patient? patient = await getPatientByPhoneFromApi(event.phone);
        if (patient != null) {
          yield AddMemberStateSuccess(patient: patient, isAdded: false);
        } else {
          yield AddMemberStateFailure();
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield AddMemberStateFailure();
      }
    }
    if (event is AddMemberAddEvent) {
      try {
        bool isAdded = await addMember(event.familyId, event.phone);
        var currentState = state as AddMemberStateSuccess;
        if (isAdded) {
          yield AddMemberStateSuccess(patient: currentState.patient, isAdded: true);
        } else {
          yield AddMemberStateSuccess(patient: currentState.patient, isAdded: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield AddMemberStateFailure();
      }
    }
  }
}