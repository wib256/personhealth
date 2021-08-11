import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:personhealth/screens/haudq/Information.dart';
import 'package:personhealth/screens/haudq/create_account.dart';
import 'package:personhealth/screens/haudq/group.dart';
import 'package:personhealth/screens/haudq/group_detail.dart';
import 'package:personhealth/screens/haudq/profile.dart';
import 'package:personhealth/screens/haudq/temp.dart';
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/screens/login_screen.dart';
>>>>>>> dca053fabc7572a9a904529990798985e16df5f7
import 'package:personhealth/utils/local_notification_service.dart';

import 'blocs/login_blocs.dart';
import 'events/login_events.dart';
Future<void> backgroundHandler(RemoteMessage message) async {
  LocalNotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
  print(message.data.toString());
}
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(create: (context) =>LoginBloc()..add(LoginFetchEvent()),child: LoginScreen(),),
    );
  }
}
