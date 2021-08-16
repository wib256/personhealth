import 'package:personhealth/models/patient.dart';
import 'package:personhealth/models/shared.dart';

class IndividualState {
  const IndividualState();
}

class IndividualStateInitial extends IndividualState{}
class IndividualStateFailure extends IndividualState{}
class IndividualStateSuccess extends IndividualState {
  final List<Sharing> listSharing;
  final List<Patient> listShared;
  final bool isEdited;
  IndividualStateSuccess({required this.listSharing, required this.listShared, required this.isEdited});
}