import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/list_examination_blocs.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/events/list_examination_events.dart';
import 'package:personhealth/screens/haudq/group.dart';
import 'package:personhealth/screens/haudq/list_examination.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(
      BuildContext context, String name, String img, String? message) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    if (message!.contains('has invited you to join the group')) {
      _notificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (String? route) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => GroupBloc()..add(GroupFetchEvent()),
                      child: ListGroup(
                        name: name,
                        image: img,
                      ),
                    )));
      });
    } else {
      _notificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (String? route) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) => ListExaminationBloc()
                        ..add(ListExaminationFetchEvent()),
                      child: ListExamination(
                        name: name,
                        image: img,
                      ),
                    )));
      });
    }
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "phrNotification",
        "phrNotification channel",
        "this is our channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
