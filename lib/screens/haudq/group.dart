import 'dart:math';

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
      image: "xxx",
      name: '',
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: width * 0.03,
                    bottom: height * 0.02,
                  ),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Individual Share",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: width * 0.03,
                    bottom: height * 0.02,
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contex) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          title: Center(
                            child: Text(
                              "Create new group",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          ),
                          content: Container(
                            height: height * 0.08,
                            child: Center(
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    labelText: "Input name of your group"),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Cancle",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Create",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.group_add,
                      color: Colors.blueGrey,
                      size: height * 0.04,
                    ),
                  ),
                ),
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
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
