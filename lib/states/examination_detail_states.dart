import 'package:equatable/equatable.dart';
import 'package:personhealth/models/examination_detail.dart';

abstract class ExaminationDetailExpandState extends Equatable {
  const ExaminationDetailExpandState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExaminationDetailStateInitial extends ExaminationDetailExpandState {}
class ExaminationDetailStateFailure extends ExaminationDetailExpandState {}
class ExaminationDetailStateSuccess extends ExaminationDetailExpandState {
  final List<ExaminationDetailExpand> list;

  const ExaminationDetailStateSuccess({required this.list});

  @override
  // TODO: implement props
  List<Object?> get props => [list];

  ExaminationDetailStateSuccess cloneWith({required List<ExaminationDetailExpand> list}) {
    return ExaminationDetailStateSuccess(list: list);
  }
}
