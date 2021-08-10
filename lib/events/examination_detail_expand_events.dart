import 'package:personhealth/blocs/examination_detail_expand_bloc.dart';

class ExaminationDetailExpandFetchEvent extends ExaminationDetailExpandBloc {
  final int examinationID;
  final String date;

  ExaminationDetailExpandFetchEvent(this.examinationID, this.date);
}