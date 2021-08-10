import 'package:equatable/equatable.dart';
import 'package:personhealth/models/examination_detail.dart';

abstract class ExaminationDetailExpandState extends Equatable {
  const ExaminationDetailExpandState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExaminationDetailExpandStateInitial extends ExaminationDetailExpandState {}
class ExaminationDetailExpandStateFailure extends ExaminationDetailExpandState {}
class ExaminationDetailExpandStateSuccess extends ExaminationDetailExpandState {
  final List<ExaminationDetailExpand> list;

  const ExaminationDetailExpandStateSuccess({required this.list});

  @override
  // TODO: implement props
  List<Object?> get props => [list];

  ExaminationDetailExpandStateSuccess cloneWith({required List<ExaminationDetailExpand> list}) {
    return ExaminationDetailExpandStateSuccess(list: list);
  }
}

class ExaminationDetailState {
  const ExaminationDetailState();
}

class ExaminationDetailStateInitial extends ExaminationDetailState{}
class ExaminationDetailStateFailure extends ExaminationDetailState{}
class ExaminationDetailStateSuccess extends ExaminationDetailState{
  final List<ExaminationDetailExpand> list;
  ExaminationDetailStateSuccess({required this.list});
}


