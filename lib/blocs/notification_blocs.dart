import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/notification_events.dart';
import 'package:personhealth/models/group.dart';
import 'package:personhealth/repositorys/group_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/states/notification_states.dart';

class NotificationBloc extends Bloc<NotificationBloc, NotificationState>{
  NotificationBloc():super(NotificationStateInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationBloc event) async* {
    if (event is NotificationFetchEvent) {
      try {
        List<Group> groups = await getInvitedGroup();
        yield NotificationStateSuccess(groups: groups, isAccepted: false, isRejected: false);
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield NotificationStateFailure();
      }
    }
    if (event is NotificationAcceptEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        bool isAccept = await acceptInvited(event.familyId, patientId!);
        if (isAccept) {
          List<Group> groups = await getInvitedGroup();
          yield NotificationStateSuccess(groups: groups, isAccepted: true, isRejected: false);
        } else {
          List<Group> groups = await getInvitedGroup();
          yield NotificationStateSuccess(groups: groups, isAccepted: false, isRejected: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield NotificationStateFailure();
      }
    }
    if (event is NotificationRejectEvent) {
      try {
        int? patientId = await LocalData().getPatientId();
        bool isReject = await rejectInvited(event.familyId, patientId!);
        if (isReject) {
          List<Group> groups = await getInvitedGroup();
          yield NotificationStateSuccess(groups: groups, isAccepted: false, isRejected: true);
        } else {
          List<Group> groups = await getInvitedGroup();
          yield NotificationStateSuccess(groups: groups, isAccepted: false, isRejected: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield NotificationStateFailure();
      }
    }
  }
}