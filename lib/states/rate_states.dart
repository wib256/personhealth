import 'package:equatable/equatable.dart';

abstract class RateStates {
  const RateStates();
}

class RateStateInitial extends RateStates {
}
class RateStateFailure extends RateStates {}
class RateStateSuccess extends RateStates {
  final String result;

  const RateStateSuccess({required this.result});
}