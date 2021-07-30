import 'package:personhealth/blocs/clinic_blocs.dart';

class ClinicFetchEvent extends ClinicBloc{}

class ClinicSearchEvent extends ClinicBloc{
  final String search;

  ClinicSearchEvent({required this.search});
}