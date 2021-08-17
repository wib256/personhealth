import 'package:personhealth/models/group.dart';

class NotificationState {
  const NotificationState();
}

class NotificationStateInitial extends NotificationState {}
class NotificationStateFailure extends NotificationState {}
class NotificationStateSuccess extends NotificationState {
  final List<Group> groups;
  final bool isAccepted;
  final bool isRejected;
  NotificationStateSuccess({required this.groups, required this.isAccepted, required this.isRejected});
}