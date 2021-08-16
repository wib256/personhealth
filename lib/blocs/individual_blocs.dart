import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/individual_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/models/shared.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/repositorys/sharing_repository.dart';
import 'package:personhealth/states/individual_states.dart';

class IndividualBloc extends Bloc<IndividualBloc, IndividualState> {
  IndividualBloc():super(IndividualStateInitial());

  @override
  Stream<IndividualState> mapEventToState(IndividualBloc event) async* {
    if (event is IndividualFetchEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        List<Sharing> listSharing = await getSharingList();
        List<Shared> listShared = await getSharedList();
        List<Patient> patients = [];
        for (int i = 0; i < listShared.length; i++) {
          Patient? patient = await getDataSharingOfPatientWithOtherPatient(listShared[i].id, patientId!);
          if (patient != null) {
            patient.setId(listShared[i].id);
            patient.setName(listShared[i].name);
            patient.setImage(listShared[i].image);
            patients.add(patient);
          }
        }
        yield IndividualStateSuccess(listSharing: listSharing, listShared: patients, isEdited: false);
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield IndividualStateFailure();
      }
    }
    if (event is IndividualEditEvent) {
      try {
        var currentState = state as IndividualStateSuccess;
        bool isEdited = await editSharingInformationToPatient(event.bodyIndex, event.legalInformation, event.prehistoricInformation, event.patientId);
        if (isEdited) {
          yield IndividualStateSuccess(listSharing: currentState.listSharing, listShared: currentState.listShared, isEdited: true);
        } else {
          yield IndividualStateSuccess(listSharing: currentState.listSharing, listShared: currentState.listShared, isEdited: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield IndividualStateFailure();
      }
    }
  }
}