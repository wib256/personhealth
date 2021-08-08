import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/models/comment.dart';

class ClinicDetailStates {
  const ClinicDetailStates();
}

class ClinicDetailStateInitial extends ClinicDetailStates{}
class ClinicDetailStateFailure extends ClinicDetailStates{}
class ClinicDetailStateSuccess extends ClinicDetailStates{
  final double rate;
  final Clinic clinic;
  final List<Comment> comments;
  ClinicDetailStateSuccess({required this.rate, required this.clinic, required this.comments});
}