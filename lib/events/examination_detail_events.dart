import 'package:personhealth/blocs/examination_detail_blocs.dart';
import 'package:personhealth/models/rating.dart';

class ExaminationDetailFetchEvent extends ExaminationDetailBloc{
  final int examinationID;
  final String date;
  ExaminationDetailFetchEvent({required this.examinationID, required this.date});
}

class ExaminationDetailRateEvent extends ExaminationDetailBloc {
  final Rating rating;
  ExaminationDetailRateEvent({required this.rating});
}