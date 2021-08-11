import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/group_detail_blocs.dart';
import 'package:personhealth/states/group_detail_states.dart';

class GroupDetail extends StatefulWidget {
  final String roleInGroup;

  const GroupDetail({required this.roleInGroup});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            bottom: height * 0.1 + 10,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<GroupDetailBloc, GroupDetailState>(
                          builder: (context, state) {
                        if (state is GroupDetailStateSuccess) {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.patients.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    height: height * 0.1,
                                    width: width * 0.95,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.green.shade100,
                                            blurRadius: 20)
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: height * 0.1,
                                          width: width * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${state.patients[index].image}"),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "${state.patients[index].name}",
                                            style: TextStyle(
                                              fontSize: 23,
                                              color: Colors.blueGrey[500],
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 3,
                                            softWrap: true,
                                          ),
                                        ),
                                        Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.person_remove,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        Center(
                                          child: PopupMenuButton(
                                            icon: Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.green,
                                              size: 30,
                                            ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        title: Center(
                                                          child: Text(
                                                            "Legal information",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueGrey),
                                                          ),
                                                        ),
                                                        content: Container(
                                                          height: height * 0.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          child: Expanded(
                                                            child: Center(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    _buildRow(
                                                                      width,
                                                                      "Name",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Phone",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Address",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Gender",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Date of birth",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                        'Legal information'),
                                                  ),
                                                ),
                                                value: 1,
                                              ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (contex) =>
                                                          AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        title: Center(
                                                          child: Text(
                                                            "Body information",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueGrey),
                                                          ),
                                                        ),
                                                        content: Container(
                                                          height: height * 0.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          child: Expanded(
                                                            child: Center(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    _buildRow(
                                                                      width,
                                                                      "Height",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Weight",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Eyesight",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                        'Body information'),
                                                  ),
                                                ),
                                                value: 2,
                                              ),
                                              PopupMenuItem(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (contex) =>
                                                          AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        title: Center(
                                                          child: Text(
                                                            "Medical history",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueGrey),
                                                          ),
                                                        ),
                                                        content: Container(
                                                          height: height * 0.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          child: Expanded(
                                                            child: Center(
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    _buildRow(
                                                                      width,
                                                                      "Disease history",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "History of surgery",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "Allergies",
                                                                      Color(
                                                                          0xffcef4e8),
                                                                    ),
                                                                    _buildRow(
                                                                      width,
                                                                      "ket qua",
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {},
                                                              child: Text(
                                                                "Ok",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: ListTile(
                                                    title:
                                                        Text('Medical history'),
                                                  ),
                                                ),
                                                value: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(child: _buildAppBar(), top: 0, left: 0, right: 0),
          Positioned(
            child: widget.roleInGroup.compareTo('leader') == 0
                ? Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffcef4e8),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green.shade100, blurRadius: 20)
                        ],
                      ),
                      width: width * 0.92,
                      height: height * 0.1,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.add_box_rounded),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Add'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Rename'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Change'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffcef4e8),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green.shade100, blurRadius: 20)
                        ],
                      ),
                      width: width * 0.92,
                      height: height * 0.1,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Edit'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Rename'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Change'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            bottom: 0,
          )
        ],
      ),
    );
  }

  Container _buildRow(double width, String title, Color color) {
    return Container(
      color: color,
      width: width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "$title",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildAppBar() {
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
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Group details",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
