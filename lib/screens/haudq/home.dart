import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/clinic_detail_blocs.dart';
import 'package:personhealth/blocs/examination_detail_blocs.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/home_blocs.dart';
import 'package:personhealth/blocs/list_clinic_blocs.dart';
import 'package:personhealth/blocs/list_examination_blocs.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/blocs/profile_blocs.dart';
import 'package:personhealth/events/clinic_detail_event.dart';
import 'package:personhealth/events/examination_detail_events.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/events/home_events.dart';
import 'package:personhealth/events/list_clinic_events.dart';
import 'package:personhealth/events/list_examination_events.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/events/profile_events.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/models/examination.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/notification.dart';
import 'package:personhealth/screens/haudq/list_clinic.dart';
import 'package:personhealth/states/home_states.dart';
import 'package:personhealth/utils/local_notification_service.dart';
import 'profile.dart';

import '../login_screen.dart';
import 'clinic_details.dart';
import 'examination_detail.dart';
import 'group.dart';
import 'list_examination.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String image;
  const HomeScreen({required this.name, required this.image});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _value = 0;

  @override
  void initState() {

    FirebaseMessaging.instance
        .getToken()
        .then((value) async {
      String? fcm_token = await updateToken(value!);
      print(value);
      if (fcm_token != null) {
        if (fcm_token.isNotEmpty) {
          print('value token: ' + fcm_token);
        } else {
          print('Get update tokent fail');
        }
      }
    });




    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationService.initialize(context, widget.name, widget.image, message.notification!.body);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        LocalNotificationService.initialize(context, widget.name, widget.image, message.notification!.body);
      }


    });



    super.initState();
  }

  Future<void> logout() async {
    await LocalData().logOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(
            create: (context) => LoginBloc()..add(LoginFetchEvent()),
            child: LoginScreen()),
      ),
      (Route route) => false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xffcef4e8), Colors.green.shade50, Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          SafeArea(
            child: Container(
              width: 210,
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is HomeStateInitial) {
                              return Expanded(
                                  child: Center(
                                child: CircularProgressIndicator(),
                              ));
                            }
                            if (state is HomeStateFailure) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ProfileBloc()..add(ProfileFetchEvent()), child: Profile(image: widget.image, name: widget.name,),)));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(
                                          "${widget.image}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${widget.image}",
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 20),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is HomeStateSuccess) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ProfileBloc()..add(ProfileFetchEvent()), child: Profile(image: widget.image, name: widget.name,),)));
                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50.0,
                                      backgroundImage:
                                          NetworkImage("${state.image}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${state.name}",
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 18),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Text('Other state');
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              HomeBloc()..add(HomeFetchEvent()),
                                          child: HomeScreen(
                                            name: widget.name,
                                            image: widget.image,
                                          ),
                                        )));
                          },
                          leading: Icon(
                            Icons.home,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            "Home",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => ListClinicBloc()
                                            ..add(ListClinicFetchEvent()),
                                          child: ListClinic(
                                            name: widget.name,
                                            image: widget.image,
                                          ),
                                        )));
                          },
                          leading: Icon(
                            Icons.local_hospital,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            "Clinic",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) =>
                                              ListExaminationBloc()
                                                ..add(
                                                    ListExaminationFetchEvent()),
                                          child: ListExamination(
                                            name: widget.name,
                                            image: widget.image,
                                          ),
                                        )));
                          },
                          leading: Icon(
                            Icons.all_inbox_sharp,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            "Examination",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => GroupBloc()..add(GroupFetchEvent()), child: ListGroup(name: widget.name, image: widget.image,),)));
                          },
                          leading: Icon(
                            Icons.group,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            "Group",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            logout();
                          },
                          leading: Icon(
                            Icons.logout,
                            color: Colors.blueGrey,
                          ),
                          title: Text(
                            "Log out",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //tween animation to create animation
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _value),
            duration: Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return (
                  //create transfer for widget
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..setEntry(0, 3, 200 * val)
                        ..rotateY((pi / 6) * val),
                      child: Scaffold(
                        backgroundColor: Color(0xffF9F9F9),
                        body: Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: CustomPaint(
                                painter: PathPainter(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AppBar(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        leading: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _value == 0
                                                  ? _value = 1
                                                  : _value = 0;
                                            });
                                          },
                                          child: Icon(
                                            Icons.menu,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, right: 10, top: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Choose a method",
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        BlocProvider(
                                                                          create: (context) => ListClinicBloc()
                                                                            ..add(ListClinicFetchEvent()),
                                                                          child:
                                                                              ListClinic(
                                                                            name:
                                                                                widget.name,
                                                                            image:
                                                                                widget.image,
                                                                          ),
                                                                        )));
                                                      },
                                                      child: methodContainer(
                                                          "clinic.png",
                                                          "Clinics"),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        BlocProvider(
                                                                          create: (context) => ListExaminationBloc()
                                                                            ..add(ListExaminationFetchEvent()),
                                                                          child:
                                                                              ListExamination(
                                                                            name:
                                                                                widget.name,
                                                                            image:
                                                                                widget.image,
                                                                          ),
                                                                        )));
                                                      },
                                                      child: methodContainer(
                                                          "examination.png",
                                                          "Examination"),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => GroupBloc()..add(GroupFetchEvent()), child: ListGroup(name: widget.name, image: widget.image,),)));
                                                      },
                                                      child: methodContainer(
                                                          "img1.png", "Group"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Top clinics",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 300,
                                              child: BlocBuilder<HomeBloc,
                                                      HomeState>(
                                                  builder: (context, state) {
                                                if (state is HomeStateInitial) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    color: Color(0xffcef4e8),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (state is HomeStateFailure) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    color: Color(0xffcef4e8),
                                                    child: Text(
                                                      'Cannot connect to the system',
                                                    ),
                                                  );
                                                }
                                                if (state is HomeStateSuccess) {
                                                  if (state.clinics.isEmpty) {
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      color: Color(0xffcef4e8),
                                                      child: Text(
                                                          'There are no clinics near your location'),
                                                    );
                                                  }
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        state.clinics.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                          child: cardClinic(
                                                              state.clinics[
                                                                  index],
                                                              context),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                                return Text('Other state');
                                              }),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Examination last",
                                              style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              child: BlocBuilder<HomeBloc,
                                                      HomeState>(
                                                  builder: (context, state) {
                                                if (state is HomeStateInitial) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    height: 60,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    color: Color(0xffcef4e8),
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (state is HomeStateFailure) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    height: 50,
                                                    alignment: Alignment.center,
                                                    color: Color(0xffcef4e8),
                                                    child: Text(
                                                      'Cannot connect to the system',
                                                    ),
                                                  );
                                                }
                                                if (state is HomeStateSuccess) {
                                                  if (state.examination.id ==
                                                      0) {
                                                    return Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      color: Color(0xffcef4e8),
                                                      child: Text(
                                                          'You have not had any tests.'),
                                                    );
                                                  }
                                                  return cardExamination(
                                                      state.examination,
                                                      context);
                                                }
                                                return Text('Other state');
                                              }),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )));
            },
          ),
        ],
      ),
    ));
  }

  Widget methodContainer(String imgName, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/img/$imgName',
          height: 100,
          width: 100,
        ),
        Text(
          "$title",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
        )
      ],
    );
  }

  Widget cardExamination(Examination examination, BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                  ExaminationDetailBloc()
                    ..add(ExaminationDetailFetchEvent(
                        examinationID: examination.id,
                        date: examination.date)),
                  child: ExaminationDetail(
                    examination: examination,
                  ),
                )));
      },
      child: Container(
        height: height * 0.15,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [BoxShadow(color: Colors.green.shade100, blurRadius: 20)],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Container(
              width: width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/exam.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                    size: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.cyan[800],
                  ),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Container(
                    width: width * 0.5,
                    child: Center(
                      child: Text(
                        "${examination.clinicName}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey[500],
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.date_range,
                    size: 18,
                    color: Colors.cyan[800],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${examination.date}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(width: width*0.3,),
                  Text(
                    "view details",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.cyan,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.cyan,
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget cardClinic(Clinic clinic, BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Card(
      shadowColor: Colors.green.shade100,
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => ClinicDetailBloc()
                            ..add(ClinicDetailFetchEvent(clinic: clinic)),
                          child: ClinicDetail(),
                        )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      "${clinic.image}",
                    ),
                  ),
                ),
                height: height * 0.221,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "${clinic.name}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 20),
                    child: Icon(
                      Icons.phone,
                      size: 17,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "${clinic.phone}",
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey[500]),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 20),
                      child: Icon(
                        Icons.location_pin,
                        size: 17,
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "${clinic.address}",
                        style: TextStyle(
                            fontSize: 15, color: Colors.blueGrey[500]),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Color(0xffcef4e8);

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
