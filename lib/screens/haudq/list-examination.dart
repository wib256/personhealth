import 'dart:math';

import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';

import './mycolor.dart';

class ListExamination extends StatefulWidget {
  @override
  State<ListExamination> createState() => _ListClinicState();
}

class _ListClinicState extends State<ListExamination> {
  late double _value = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return MasterLayout(
      title: 'All examincation',
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: DateRangeField(
                  enabled: true,
                  initialValue: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(Duration(days: 5))),
                  decoration: InputDecoration(
                    labelText: 'Date Range',
                    prefixIcon: Icon(Icons.date_range),
                    hintText: 'Please select a start and end date',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.start.isBefore(DateTime.now())) {
                      return 'Please enter a later start date';
                    }
                    return null;
                  },
                  onSaved: (value) {}),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width * 0.95,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(color: Colors.green.shade100, blurRadius: 20)
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/img/exam.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_hospital,
                                  size: 25,
                                  color: Colors.cyan[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Phòng Khám Đa Khoa DHA",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueGrey[500],
                                    fontWeight: FontWeight.bold,
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
                                  "09-08-2021 1:18 AM",
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
                                SizedBox(
                                  width: width * 0.4,
                                ),
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
                            )
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
