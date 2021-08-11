import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:personhealth/screens/haudq/Information.dart';
import 'package:personhealth/screens/haudq/create_account.dart';
import 'package:personhealth/screens/haudq/group.dart';
import 'package:personhealth/screens/haudq/group_detail.dart';
import 'package:personhealth/screens/haudq/profile.dart';
import 'package:personhealth/screens/haudq/temp.dart';
import 'package:personhealth/utils/local_notification_service.dart';
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
      home: 
      // ExaminationDetail()
      // ListExamination()
      // HomeScreen()
      // clinicDetail()
      // ListClinic()
      // BlocProvider(create: (context) =>LoginBloc()..add(LoginFetchEvent()),child: LoginScreen(),)
      CreateAccount(), 
    );
  }
}
