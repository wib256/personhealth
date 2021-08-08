import 'package:personhealth/blocs/list_clinic_blocs.dart';

class ListClinicFetchEvent extends ListClinicBloc {}
class ListClinicSearchEvent extends ListClinicBloc {
  final String searchClinic;
  ListClinicSearchEvent({required this.searchClinic});
}