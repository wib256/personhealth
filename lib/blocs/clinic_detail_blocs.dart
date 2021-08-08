import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/clinic_detail_event.dart';
import 'package:personhealth/models/comment.dart';
import 'package:personhealth/repositorys/comment_repository.dart';
import 'package:personhealth/states/clinic_detail_states.dart';

class ClinicDetailBloc extends Bloc<ClinicDetailBloc, ClinicDetailStates>{
  ClinicDetailBloc():super(ClinicDetailStateInitial());

  @override
  Stream<ClinicDetailStates> mapEventToState(ClinicDetailBloc event) async* {
    if (event is ClinicDetailFetchEvent) {
      List<Comment> comments = await getListComment(event.clinic.id);
      double rate = 0;
      if (comments.length > 0) {
        for (int i = 0; i < comments.length; i++) {
          rate = rate + comments[i].rate;
        }
        rate = rate / (comments.length - 1);
        yield ClinicDetailStateSuccess(rate: rate, clinic: event.clinic, comments: comments);
      } else {
        yield ClinicDetailStateSuccess(rate: rate, clinic: event.clinic, comments: comments);
      }
    }
  }
}