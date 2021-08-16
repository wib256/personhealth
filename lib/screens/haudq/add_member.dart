import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/add_member_blocs.dart';
import 'package:personhealth/events/add_member_events.dart';
import 'package:personhealth/states/add_member_states.dart';

class AddMember extends StatefulWidget {
  final int familyId;
  const AddMember({required this.familyId});

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  late AddMemberBloc _addMemberBloc;
  final _searchController = TextEditingController();

  @override
  void initState() {
    _addMemberBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffcef4e8),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          'Add member',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) {
                  _addMemberBloc.add(AddMemberSearchEvent(
                      phone: _searchController.text.trim()));
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          BlocBuilder<AddMemberBloc, AddMemberState>(builder: (context, state) {
            if (state is AddMemberStateInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AddMemberStateFailure) {
              return Center(
                child: Text('No result'),
              );
            }
            if (state is AddMemberStateSuccess) {
              return Center(
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
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
                                '${state.patient.image}'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.55,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${state.patient.name}",
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
                      BlocListener<AddMemberBloc, AddMemberState>(
                          bloc: _addMemberBloc,
                          listener: (context, state) {
                            if (state is AddMemberStateSuccess) {
                              if (state.isAdded) {
                                _displayAddMemberTopMotionToast(context, 0);
                              } else {
                                _displayAddMemberTopMotionToast(context, 1);
                              }
                            }
                          },
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                _addMemberBloc.add(AddMemberAddEvent(phone: _searchController.text.trim(), familyId: widget.familyId));
                              },
                              child: Text('Add'),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text('Other state');
          }),
        ],
      ),
    );
  }

  _displayAddMemberTopMotionToast(BuildContext context, int result) {
    switch (result) {
      case 1:
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Group adding failed",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Successful group name add",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
