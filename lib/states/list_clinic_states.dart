import 'package:personhealth/models/clinic.dart';

class ListClinicState {
  const ListClinicState();
}

class ListClinicStateInitial extends ListClinicState {}
class ListClinicStateFailure extends ListClinicState {}
class ListClinicStateSuccess extends ListClinicState {
  final List<Clinic> clinics;

  ListClinicStateSuccess({required this.clinics});
}