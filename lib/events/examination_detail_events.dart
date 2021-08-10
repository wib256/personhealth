import 'package:personhealth/blocs/examination_detail_blocs.dart';

class ExaminationDetailFetchEvent extends ExaminationDetailBloc{
  final int examinationID;
  final String date;
  ExaminationDetailFetchEvent({required this.examinationID, required this.date});
}