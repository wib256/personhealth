import 'package:personhealth/blocs/individual_blocs.dart';

class IndividualFetchEvent extends IndividualBloc{}

class IndividualEditEvent extends IndividualBloc{
  final int patientId;
  final bool bodyIndex;
  final bool legalInformation;
  final bool prehistoricInformation;
  IndividualEditEvent({required this.patientId, required this.legalInformation, required this.bodyIndex, required this.prehistoricInformation});
}