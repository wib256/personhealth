import 'package:personhealth/blocs/list_examination_blocs.dart';

class ListExaminationFetchEvent extends ListExaminationBloc{}
class ListExaminationSearchEent extends ListExaminationBloc{
  final String dateF;
  final String dateT;
  ListExaminationSearchEent({required this.dateT, required this.dateF});
}