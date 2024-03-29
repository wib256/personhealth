import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/screens/login_screen.dart';
import 'package:personhealth/utils/local_notification_service.dart';

import 'blocs/login_blocs.dart';
import 'events/login_events.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  LocalNotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
  print(message.notification!.body);
  print(message.data.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.onMessage.listen((message) {
    LocalNotificationService.display(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    LocalNotificationService.display(message);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => LoginBloc()..add(LoginFetchEvent()),
        child: LoginScreen(),
      ),
    );
  }
}
