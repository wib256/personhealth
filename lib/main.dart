import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/screens/haudq/clinic_details.dart';
import 'package:personhealth/screens/haudq/home.dart';
import 'package:personhealth/screens/haudq/list_clinic.dart';
import 'package:personhealth/screens/login_screen.dart';
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
      // HomeScreen()
      clinicDetail()
      // ListClinic()
      // BlocProvider(create: (context) =>LoginBloc()..add(LoginFetchEvent()),child: LoginScreen(),)
      // NewPatient(),
    );
  }
}
