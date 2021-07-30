import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/examination_events.dart';
import 'package:personhealth/repositorys/examination_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/rating_repository.dart';
import 'package:personhealth/states/examination_states.dart';

class ExaminationBloc extends Bloc<ExaminationBloc, ExaminationState> {
  ExaminationBloc():super(ExaminationStateInitial());

  @override
  Stream<ExaminationState> mapEventToState(ExaminationBloc event) async* {

    if (event is ExaminationFetchEvent) {
      var patientID = await LocalData().getPatientId();
      try {
        if (state is ExaminationStateInitial) {
          final examinations = await getExaminationsByPatientIdFromApi(patientID!);
          yield ExaminationStateSuccess(examinations: examinations);
        } else if (state is ExaminationStateSuccess) {
          final currentState = state as ExaminationStateSuccess;
          final examinations = await getExaminationsByPatientIdFromApi(patientID!);
          yield currentState.cloneWith(examinations: examinations);
        }
      } catch (exception) {
        yield ExaminationStateFailure();
      }
    }
    if (event is ExaminationRateEvent) {
      var patientID = await LocalData().getPatientId();
      if (state is ExaminationStateSuccess) {
        await rateExamination(event.rating);
        final examinations = await getExaminationsByPatientIdFromApi(patientID!);
        yield ExaminationStateSuccess(examinations: examinations);
      }
    }
    if (event is ExaminationSearchEvent) {
      String dateF = event.dateF;
      String dateT = event.dateT;
      var patientID = await LocalData().getPatientId();
      try {
        if (state is ExaminationStateInitial) {
          final examinations = await getExaminationsByDateFromApi(patientID!, dateF, dateT);
          yield ExaminationStateSuccess(examinations: examinations);
        } else if (state is ExaminationStateSuccess) {
          final examinations = await getExaminationsByDateFromApi(patientID!, dateF, dateT);
          yield ExaminationStateSuccess(examinations: examinations);
        }
      } catch (exception) {
        yield ExaminationStateFailure();
      }
    }
  }
}