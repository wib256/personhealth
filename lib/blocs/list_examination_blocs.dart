import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/list_examination_events.dart';
import 'package:personhealth/models/examination.dart';
import 'package:personhealth/repositorys/examination_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/states/list_examination_states.dart';

class ListExaminationBloc extends Bloc<ListExaminationBloc, ListExaminationState>{
  ListExaminationBloc():super(ListExaminationStateInitial());

  @override
  Stream<ListExaminationState> mapEventToState(ListExaminationBloc event) async* {
    if (event is ListExaminationFetchEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        List<Examination> examinations = await getExaminationsByPatientIdFromApi(patientId!);
        yield ListExaminationStateSuccess(examinations: examinations);
      } catch (exception) {
        print(exception);
        yield ListExaminationStateFailure();
      }
    }
    if (event is ListExaminationSearchEent) {
      try {
        int? patientId = await LocalData().getPatientId();
        List<Examination> examinations = await getExaminationsByDateFromApi(patientId!, event.dateF, event.dateT);
        yield ListExaminationStateSuccess(examinations: examinations);
      } catch (exception) {
        print(exception);
        yield ListExaminationStateFailure();
      }
    }
  }
}