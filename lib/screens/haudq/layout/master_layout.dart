import 'dart:math';

import 'package:flutter/material.dart';

import '../mycolor.dart';

class MasterLayout extends StatefulWidget {
  MasterLayout({Key? key, this.child, required this.title});

  @override
  State<MasterLayout> createState() => _MasterLayoutState();
  String title;
  final Widget? child;
}

class _MasterLayoutState extends State<MasterLayout> {
  late double _value = 0;

  @override
  Widget build(BuildContext context) {
    String name = widget.title;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                        body: Column(
                          children: [
                            _buildAppBar(name),
                            SizedBox(
                              height: 10,
                            ),
                            widget.child!
                          ],
                        ),
                      )));
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
        width: 200,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    "Paul",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
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
                    onTap: () {},
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
