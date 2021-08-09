import 'package:personhealth/blocs/clinic_detail_blocs.dart';
import 'package:personhealth/models/clinic.dart';

class ClinicDetailFetchEvent extends ClinicDetailBloc{
  final Clinic clinic;
  ClinicDetailFetchEvent({required this.clinic});
}