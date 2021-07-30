import 'package:equatable/equatable.dart';
import 'package:personhealth/models/examination.dart';

abstract class ExaminationState extends Equatable {
  const ExaminationState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ExaminationStateInitial extends ExaminationState {}
class ExaminationStateFailure extends ExaminationState {}
class ExaminationStateSuccess extends ExaminationState {
  final List<Examination> examinations;

  const ExaminationStateSuccess({required this.examinations});

  @override
  // TODO: implement props
  List<Object> get props => [examinations];

  @override
  String toString() => "examinations : $examinations";

  ExaminationStateSuccess cloneWith({required List<Examination> examinations}) {
    return ExaminationStateSuccess(examinations: examinations);
  }
}