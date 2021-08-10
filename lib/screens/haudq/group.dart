import 'dart:math';

import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';

import './mycolor.dart';

class ListGroup extends StatefulWidget {
  @override
  State<ListGroup> createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  late double _value = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return MasterLayout(
      title: 'All Groups',
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    width * 0.02,
                  ),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("Individual Share"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Create new group"),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Notification"),
                ),
                SizedBox(width: width * 0.02,)
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.02),
                      height: height * 0.1,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green.shade100, blurRadius: 20)
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image(
                              image: AssetImage("assets/img/group.png"),
                              width: width * 0.1,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Nhóm nhà nội Nhóm nhà nội ",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blueGrey[500],
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                                softWrap: true,
                              ),
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                          ),
                        ],
                      ),
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
