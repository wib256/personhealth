import 'package:personhealth/blocs/notification_blocs.dart';

class NotificationFetchEvent extends NotificationBloc{}
class NotificationAcceptEvent extends NotificationBloc {
  final int familyId;
  NotificationAcceptEvent({required this.familyId});
}

class NotificationRejectEvent extends NotificationBloc {
  final int familyId;
  NotificationRejectEvent({required this.familyId});
}