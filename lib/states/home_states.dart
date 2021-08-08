import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/models/examination.dart';

class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState{}
class HomeStateFailure extends HomeState{}
class HomeStateSuccess extends HomeState{
  final String name, image;
  final List<Clinic> clinics;
  final Examination examination;

  HomeStateSuccess({required this.name, required this.image, required this.clinics, required this.examination});
}