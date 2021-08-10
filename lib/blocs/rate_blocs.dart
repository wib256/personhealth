import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/rate_events.dart';
import 'package:personhealth/models/rating.dart';
import 'package:personhealth/repositorys/rating_repository.dart';
import 'package:personhealth/states/rate_states.dart';

class RateBloc extends Bloc<RateBloc, RateStates> {
  RateBloc():super(RateStateInitial());

  Future<void> rateClinic(RateBloc event) async {
    if (event is RateClinicEvent) {
        Rating rating = event.rating;
        final bool result = await rateExamination(rating);
        if (result) {
          print('Thanh cong');
        } else {
          print('That bai');
      }
    }
  }

  @override
  Stream<RateStates> mapEventToState(RateBloc event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}