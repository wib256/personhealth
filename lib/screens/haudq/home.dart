import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _value = 0;

  @override
  Widget build(BuildContext context) {
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
          SafeArea(
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
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
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
          ),

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
                        body: Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: CustomPaint(
                                painter: pathPainter(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppBar(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    leading: InkWell(
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
                                          height: 20,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 120,
                                          margin: EdgeInsets.all(8),
                                          child: ListView(
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            children: <Widget>[
                                              methodContainer(
                                                  "clinic.png", "Clinics"),
                                              SizedBox(
                                                height: 5,
                                                width: 5,
                                              ),
                                              methodContainer("examination.png",
                                                  "Examination"),
                                              SizedBox(
                                                height: 5,
                                                width: 5,
                                              ),
                                              methodContainer(
                                                  "img1.png", "Group"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "Clinic near you",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Hoài Hảo"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Hoài Hảo"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Hoài Hảo"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Text(
                                          "Examination today",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics: BouncingScrollPhysics(),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Phòng khám Đa khoa Ctđ Phương Nam"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Hoài Hảo"),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  child: ClinicWidget(
                                                      "clinic.png", "Hoài Hảo"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )));
            },
          ),
        ],
      ),
    );
  }

  Container methodContainer(String imgName, String title) {
    return Container(
      width: 110,
      child: Column(
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
      ),
    );
  }

  Container ClinicWidget(String imgName, String clinicName) {
    return Container(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: Color(0xffcef4e8),
          ),
          child: Container(
            padding: EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/$imgName'),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 242,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "$clinicName",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone : ",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            "0123456789",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            child: Text(
                              "Adress : ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: 238,
                              height: 50,
                              child: Text(
                                "201A Nam Kỳ Khởi Nghĩa, Phường 7, Quận 3, Thành phố Hồ Chí Minh",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          //navigator
        },
      ),
    );
  }
}

class pathPainter extends CustomPainter {
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
    // TODO: implement shouldRepaint
    return true;
  }
}
