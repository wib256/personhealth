
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPatient extends StatefulWidget {
  @override
  State<NewPatient> createState() => _NewPatientState();
}
Future<void> changeState(int check) async{
  final pref = await SharedPreferences.getInstance();
  pref.setInt("check", check);
  print(pref.getInt("check"));
}

Future<int> getItemState() async{
  final pref = await SharedPreferences.getInstance();
  return pref.getInt("check") ?? 0;
}
class _NewPatientState extends State<NewPatient> {
  int check = 0;
  @override
  void initState() {
    getItemState().then((value) => check = value);
    if (check != 0) {
      print("///////");
      print(check);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => LoginBloc()..add(LoginFetchEvent()),
                    child: LoginScreen(),
                  )));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: PathPainter(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "PHR system",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "It has never been so easy to share and care for and store personal patient information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Image.asset(
                        'assets/img/new1.png',
                        height: 400,
                      ),
                    )),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  child: Container(
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0, 1],
                          colors: [Color(0xff54D579), Color(0xff00AABF)],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                        )),
                    child: Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    changeState(1);
                    //navigator
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) =>
                                      LoginBloc()..add(LoginFetchEvent()),
                                  child: LoginScreen(),
                                )));
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xffE4E2FF);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.6);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.5, size.width, size.height * 0.42);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
