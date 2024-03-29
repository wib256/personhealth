import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/examination_detail_events.dart';
import 'package:personhealth/models/examination_detail.dart';
import 'package:personhealth/repositorys/examination_detail_respository.dart';
import 'package:personhealth/repositorys/examination_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/rating_repository.dart';
import 'package:personhealth/states/examination_detail_states.dart';

class ExaminationDetailBloc extends Bloc<ExaminationDetailBloc, ExaminationDetailState>{
  ExaminationDetailBloc():super(ExaminationDetailStateInitial());

  @override
  Stream<ExaminationDetailState> mapEventToState(ExaminationDetailBloc event) async* {
    if (event is ExaminationDetailFetchEvent) {
      try {
        int examinationID = event.examinationID;
        String date = event.date;
        var gender = await LocalData().getGender();
        var dob = await LocalData().getDob();
        List<String> dobArray = [];
        if (dob != null) {
          dobArray = dob.split('/');
          DateTime currentDate = DateTime.now();
          if (currentDate.year - int.parse(dobArray[0])  <= 12) {
            gender = 'Child-' + gender!;
          }
        }
        var patientID = await LocalData().getPatientId();
        if (state is ExaminationDetailStateInitial) {
          final List<ExaminationDetailExpand> list = [];
          final examinationsDetail =
          await getExaminationsDetailFromApi(examinationID, gender!);
          final examinations =
          await getExaminationsByDateFromApi(patientID!, '2021-01-01', date);
          int lastID = -1;

          if (examinations.length > 1) {
            for (int i = examinations.length - 1; i > 0; i--) {
              if (examinations[i].id == examinationID && i - 1 >= 0) {
                lastID = examinations[i - 1].id;
                i = 0;
              }
            }
            if (lastID != -1) {
              final lastExaminationsDetail =
              await getExaminationsDetailFromApi(lastID, gender);
              if (lastExaminationsDetail.length > 0) {
                for (int i = 0; i < examinationsDetail.length; i++) {
                  for (int j = 0; j < lastExaminationsDetail.length; j++) {
                    if (examinationsDetail[i].testID ==
                        lastExaminationsDetail[j].testID) {
                      ExaminationDetailExpand temp = new ExaminationDetailExpand(
                          examinationsDetail[i].id,
                          examinationsDetail[i].examinationID,
                          examinationsDetail[i].testID,
                          examinationsDetail[i].result,
                          examinationsDetail[i].indexValueMax,
                          examinationsDetail[i].indexValueMin,
                          examinationsDetail[i].diagnose,
                          examinationsDetail[i].testName,
                          lastExaminationsDetail[j].result);
                      j = lastExaminationsDetail.length;
                      list.add(temp);
                    }
                    if ((j + 1) == lastExaminationsDetail.length) {
                      ExaminationDetailExpand temp = new ExaminationDetailExpand(
                          examinationsDetail[i].id,
                          examinationsDetail[i].examinationID,
                          examinationsDetail[i].testID,
                          examinationsDetail[i].result,
                          examinationsDetail[i].indexValueMax,
                          examinationsDetail[i].indexValueMin,
                          examinationsDetail[i].diagnose,
                          examinationsDetail[i].testName,
                          0);
                      list.add(temp);
                    }
                  }
                }
              } else {
                for (int i = 0; i < examinationsDetail.length; i++) {
                  ExaminationDetailExpand temp = new ExaminationDetailExpand(
                      examinationsDetail[i].id,
                      examinationsDetail[i].examinationID,
                      examinationsDetail[i].testID,
                      examinationsDetail[i].result,
                      examinationsDetail[i].indexValueMax,
                      examinationsDetail[i].indexValueMin,
                      examinationsDetail[i].diagnose,
                      examinationsDetail[i].testName,
                      0);
                  list.add(temp);
                }
              }

            } else {
              for (int i = 0; i < examinationsDetail.length; i++) {
                ExaminationDetailExpand temp = new ExaminationDetailExpand(
                    examinationsDetail[i].id,
                    examinationsDetail[i].examinationID,
                    examinationsDetail[i].testID,
                    examinationsDetail[i].result,
                    examinationsDetail[i].indexValueMax,
                    examinationsDetail[i].indexValueMin,
                    examinationsDetail[i].diagnose,
                    examinationsDetail[i].testName,
                    0);
                list.add(temp);
              }
            }
          } else {
            for (int i = 0; i < examinationsDetail.length; i++) {
              ExaminationDetailExpand temp = new ExaminationDetailExpand(
                  examinationsDetail[i].id,
                  examinationsDetail[i].examinationID,
                  examinationsDetail[i].testID,
                  examinationsDetail[i].result,
                  examinationsDetail[i].indexValueMax,
                  examinationsDetail[i].indexValueMin,
                  examinationsDetail[i].diagnose,
                  examinationsDetail[i].testName,
                  0);
              list.add(temp);
            }
          }
          yield ExaminationDetailStateSuccess(list: list, isRated: false);
        }
      } catch (exception) {
        print(exception);
        yield ExaminationDetailStateFailure();
      }
    }

    if (event is ExaminationDetailRateEvent) {
      try {
        bool isRated = await rateExamination(event.rating);
        var currentState = state as ExaminationDetailStateSuccess;
        if (isRated) {
          yield ExaminationDetailStateSuccess(list: currentState.list, isRated: true);
        } else {
          yield currentState;
        }
      } catch (exception) {
        print(exception);
        yield ExaminationDetailStateFailure();
      }
    }
  }
}