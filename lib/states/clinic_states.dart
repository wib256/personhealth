import 'package:equatable/equatable.dart';
import 'package:personhealth/models/clinic.dart';

abstract class ClinicState extends Equatable {
  const ClinicState();

  @override
  List<Object> get props => [];
}

class ClinicStateInitial extends ClinicState {}

class ClinicStateFailure extends ClinicState {}

class ClinicStateSuccess extends ClinicState {
  final List<Clinic> clinics;

  const ClinicStateSuccess(
      {required this.clinics});

  @override
  String toString() => "clinics : $clinics";

  @override
  // TODO: implement props
  List<Object> get props => [clinics];

  ClinicStateSuccess cloneWith(
      {required List<Clinic> clinics}) {
    return ClinicStateSuccess(clinics: clinics);
  }
}
