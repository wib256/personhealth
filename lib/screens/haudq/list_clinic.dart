import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';

import './mycolor.dart';

class ListClinic extends StatefulWidget {
  @override
  State<ListClinic> createState() => _ListClinicState();
}

class _ListClinicState extends State<ListClinic> {
  late double _value = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return MasterLayout(
      title: 'All clinic',
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Theme(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      fillColor: Color(0xFFF2F4F5),
                      hintStyle: new TextStyle(color: Colors.grey[600]),
                      hintText: "What address of clinic want to search",
                    ),
                    autofocus: false,
                  ),
                  data: Theme.of(context).copyWith(
                    primaryColor: Colors.grey[600],
                  )),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: height * 0.35,
                    width: width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(color: Colors.green.shade100, blurRadius: 20)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/phrsystem-a595c.appspot.com/o/67fb7e78-90ab-4a0f-a756-8fa2648db2d7.jpg?alt=media"),
                            ),
                          ),
                          height: height * 0.23,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Phòng Khám Đa Khoa DHA",
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 20),
                              child: Icon(
                                Icons.phone,
                                size: 17,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "0123456789",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueGrey[500]),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 20),
                              child: Icon(
                                Icons.location_pin,
                                size: 17,
                                color: Colors.blue,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "201A Nam Kỳ Khởi Nghĩa, Phường 7, Quận 3, Thành phố Hồ Chí Minh",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blueGrey[500]),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
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
