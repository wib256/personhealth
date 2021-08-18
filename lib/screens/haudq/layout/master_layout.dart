import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/home_blocs.dart';
import 'package:personhealth/blocs/list_clinic_blocs.dart';
import 'package:personhealth/blocs/list_examination_blocs.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/blocs/profile_blocs.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/events/home_events.dart';
import 'package:personhealth/events/list_clinic_events.dart';
import 'package:personhealth/events/list_examination_events.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/events/profile_events.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/screens/haudq/home.dart';
import 'package:personhealth/screens/haudq/list_clinic.dart';
import 'package:personhealth/screens/haudq/list_examination.dart';
import 'package:personhealth/screens/login_screen.dart';

import '../group.dart';
import '../profile.dart';

class MasterLayout extends StatefulWidget {
  final String name;
  final String image;
  MasterLayout({Key? key, this.child, required this.title, required this.name, required this.image});

  @override
  State<MasterLayout> createState() => _MasterLayoutState();
  String title;
  final Widget? child;
}

class _MasterLayoutState extends State<MasterLayout> {
  late double _value = 0;

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
  Widget build(BuildContext context) {
    String name = widget.title;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xffcef4e8), Colors.green.shade50, Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          _buildSideNav(),

          //tween animation to create animaiton
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: _value),
            duration: Duration(milliseconds: 500),
            builder: (_, double val, __) {
              return (
                  //tạo tranfer cho widget
                  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..setEntry(0, 3, 200 * val)
                        ..rotateY((pi / 6) * val),
                      child: Scaffold(
                          backgroundColor: Color(0xffF9F9F9),
                          body: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                _buildAppBar(name),
                                SizedBox(
                                  height: 10,
                                ),
                                widget.child!
                              ],
                            ),
                          ))));
            },
          ),
        ],
      ),
    );
  }

  Container _buildAppBar(String name) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        color: Color(0xffcef4e8),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            child: Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
          ),
          Positioned(
            top: 55,
            left: 10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _value == 0 ? _value = 1 : _value = 0;
                    });
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "$name",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  SafeArea _buildSideNav() {
    return SafeArea(
      child: Container(
        width: 210,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ProfileBloc()..add(ProfileFetchEvent()), child: Profile(image: widget.image, name: widget.name,),)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                          "${widget.image}"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.name}",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  ],
                ),
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
                                child: HomeScreen(name: widget.name, image: widget.image,),
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
                              builder:
                                  (context) =>
                                  BlocProvider(
                                    create: (context) => ListClinicBloc()
                                      ..add(ListClinicFetchEvent()),
                                    child:
                                    ListClinic(name: widget.name, image: widget.image,),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ListExaminationBloc()..add(ListExaminationFetchEvent()), child: ListExamination(name: widget.name, image: widget.image,),)));
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
    );
  }
}
