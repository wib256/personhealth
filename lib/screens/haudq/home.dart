import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/home_blocs.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/models/examination.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/states/home_states.dart';

import '../login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _value = 0;

  @override
  void initState() {
    super.initState();
  }



  Future<void> logout() async {
    await LocalData().logOut();
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => BlocProvider(create: (context) => LoginBloc()..add(LoginFetchEvent()), child: LoginScreen()),
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
                    colors: [
                      Color(0xffcef4e8),
                      Colors.green.shade50,
                      Colors.white
                    ],
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
                                return Expanded(child: Center(child: CircularProgressIndicator(),));
                              }
                              if (state is HomeStateFailure) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(
                                          "https://cdn2.vectorstock.com/i/1000x1000/20/76/man-avatar-profile-vector-21372076.jpg"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "...",
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 20),
                                    ),
                                  ],
                                );
                              }
                              if (state is HomeStateSuccess) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 50.0,
                                      backgroundImage: NetworkImage(
                                          "${state.image}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${state.name}",
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 20),
                                    ),
                                  ],
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
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
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
                            onTap: () {},
                            leading: Icon(
                              Icons.group_sharp,
                              color: Colors.blueGrey,
                            ),
                            title: Text(
                              "Home",
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

            //tween animation to create animaiton
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
                                padding:
                                EdgeInsets.only(left: 20, right: 20),
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
                                                      methodContainer(
                                                          "clinic.png",
                                                          "Clinics"),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      methodContainer(
                                                          "examination.png",
                                                          "Examination"),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      methodContainer(
                                                          "img1.png",
                                                          "Group"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Clinic near you",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 250,
                                                child: BlocBuilder<HomeBloc, HomeState>(
                                                    builder: (context, state) {
                                                      if (state is HomeStateInitial) {
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          color: Color(0xffcef4e8),
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      }
                                                      if (state is HomeStateFailure) {
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          color: Color(0xffcef4e8),
                                                          child: Text('Cannot connect to the system',),
                                                        );
                                                      }
                                                      if (state is HomeStateSuccess) {
                                                        if (state.clinics.isEmpty) {
                                                          return Container(
                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                            color: Color(0xffcef4e8),
                                                            child: Text('There are no clinics near your location'),
                                                          );
                                                        }
                                                        return ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: BouncingScrollPhysics(),
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: state.clinics.length,
                                                          itemBuilder: (context, index) {
                                                            return Padding(
                                                              padding: const EdgeInsets.only(right: 10),
                                                              child: Container(
                                                                child: cardClinic(state.clinics[index].image, state.clinics[index].name, state.clinics[index].address),
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
                                                "Examination today",
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                child: BlocBuilder<HomeBloc, HomeState>(
                                                    builder: (context, state) {
                                                      if (state is HomeStateInitial) {
                                                        return Container(
                                                          alignment: Alignment.center,
                                                          height: 60,
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          color: Color(0xffcef4e8),
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      }
                                                      if (state is HomeStateFailure) {
                                                        return Container(
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          height: 50,
                                                          alignment: Alignment.center,
                                                          color: Color(0xffcef4e8),
                                                          child: Text('Cannot connect to the system',),
                                                        );
                                                      }
                                                      if (state is HomeStateSuccess) {
                                                        if (state.examination.id == 0 ) {
                                                          return Container(
                                                            alignment: Alignment.center,
                                                            height: 50,
                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                            color: Color(0xffcef4e8),
                                                            child: Text('You have not had any tests.'),
                                                          );
                                                        }
                                                        return cardExamination(state.examination);
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
      )
    );
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

  Widget cardExamination(Examination examination) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: (){},
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Color(0xffcef4e8),
          ),
          child: ListTile(
            leading: Icon(Icons.file_copy_outlined),
            title: Text('Examination', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${examination.date}'),
                Text('Diagnose: ${examination.diagnose}', softWrap: true, overflow: TextOverflow.ellipsis,),
                Text('Advise: ${examination.advise}', softWrap: true, overflow: TextOverflow.ellipsis,),
                Text('Clinic: ${examination.clinicName}', softWrap: true, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 5,),
                // Container(
                //   alignment: Alignment.bottomRight,
                //   child: GestureDetector(
                //     onTap: (){},
                //     child: Container(
                //       height: 40,
                //       width: 70,
                //       margin: EdgeInsets.symmetric(horizontal: 50),
                //       decoration: BoxDecoration(
                //           color: examination.rateStatus == 'enable' ?  Colors.cyan.shade500 : examination.rateStatus,
                //           borderRadius: BorderRadius.circular(10)),
                //       child: Center(
                //         child: examination.rateStatus == 'enable' ? Text(
                //           "Rated",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold),
                //         ) : examination.rateStatus == 'expire' ? Text(
                //           "Expire",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold),
                //         ) : Text(
                //           "Rate",
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardClinic(String imgName, String clinicName, String address) {
    return Card(
      elevation: 5,
      child: Container(
        height: 230,
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Color(0xffcef4e8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(clinicName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), softWrap: true, overflow: TextOverflow.ellipsis,),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,0,5,0),
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imgName),
                        fit: BoxFit.fitWidth,
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Text('Location: $address', softWrap: true, overflow: TextOverflow.ellipsis, maxLines: 2,),
                ),
              ],
            ),
          ),
          onTap: () {
            //navigator
          },
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
