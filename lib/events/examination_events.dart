import 'package:personhealth/blocs/examination_blocs.dart';
import 'package:personhealth/models/rating.dart';

class ExaminationFetchEvent extends ExaminationBloc {}
class ExaminationSearchEvent extends ExaminationBloc{
  final String dateT, dateF;

  ExaminationSearchEvent({required this.dateT,required this.dateF});
}

class ExaminationRateEvent extends ExaminationBloc {
  final Rating rating;

  ExaminationRateEvent({required this.rating});
}