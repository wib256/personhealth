import 'package:personhealth/models/examination.dart';

class ListExaminationState {
  const ListExaminationState();
}

class ListExaminationStateInitial extends ListExaminationState {}
class ListExaminationStateFailure extends ListExaminationState {}
class ListExaminationStateSuccess extends ListExaminationState {
  final List<Examination> examinations;
  ListExaminationStateSuccess({required this.examinations});
}