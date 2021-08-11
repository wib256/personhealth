import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/group_detail_blocs.dart';
import 'package:personhealth/events/group_detail_events.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';
import 'package:personhealth/states/group_states.dart';

import 'group_detail.dart';

class ListGroup extends StatefulWidget {
  final String name;
  final String image;

  const ListGroup({required this.name, required this.image});

  @override
  State<ListGroup> createState() => _ListGroupState();
}

class _ListGroupState extends State<ListGroup> {
  final _groupNameController = TextEditingController();
  late GroupBloc _groupBloc;


  @override
  void initState() {
    _groupBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return MasterLayout(
      title: 'All Groups',
      image: "${widget.image}",
      name: '${widget.name}',
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
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          title: Center(
                            child: Text(
                              "Create new group",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          ),
                          content: Container(
                            height: height * 0.08,
                            child: Center(
                              child: TextField(
                                controller: _groupNameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  labelText: "Group's name",
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            BlocListener<GroupBloc, GroupState>(
                              bloc: _groupBloc,
                              listener: (context, state) {
                                if (state is GroupStateSuccess) {
                                  if (state.isCreated) {
                                    Navigator.pop(context);
                                    _displayTopMotionToast(context, 0);
                                  } else {
                                    Navigator.pop(context);
                                    _displayTopMotionToast(context, 1);
                                  }
                                }
                              },
                              child: TextButton(
                                onPressed: () {
                                  print(_groupNameController.text);
                                  _groupBloc.add(GroupCreateEvent(groupName: _groupNameController.text));
                                },
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
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
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
                    if (state is GroupStateFailure) {
                      return Expanded(
                          child: Center(
                            child: Text('Cannot connect to the system'),
                          ));
                    }
                    if (state is GroupStateInitial) {
                      return SizedBox();
                    }
                    if (state is GroupStateSuccess) {
                      if (state.listGroup.isEmpty) {
                        return Expanded(
                            child: Center(
                              child: Text('You have not joined any groups yet'),
                            ));
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.listGroup.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                               BlocProvider(create: (context) => GroupDetailBloc()..add(GroupDetailFetchEvent(familyId: state.listGroup[index].id)), child:  GroupDetail(roleInGroup: state.listGroup[index].roleInTheGroup,),)));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: height * 0.1,
                                    width: width * 0.9,
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
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  '${state.listGroup[index].avatar}'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${state.listGroup[index].name}",
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return SizedBox();
                  }),
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

  _displayTopMotionToast(BuildContext context, int result) {
    switch (result) {
      case 1:
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Create group is failure",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Create group is success",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
