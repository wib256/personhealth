import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/notification_blocs.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/events/notification_events.dart';
import 'package:personhealth/states/notification_states.dart';

import 'group.dart';

class NotificationScreen extends StatefulWidget {
  final String name;
  final String image;
  const NotificationScreen({required this.name,required this.image});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    _notificationBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffcef4e8),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => GroupBloc()..add(GroupFetchEvent()), child: ListGroup(name: widget.name, image: widget.image,),)));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationStateFailure) {
                    return Center(
                      child: Text('Unable to connect to the system.'),);
                  }
                  if (state is NotificationStateSuccess) {
                    if (state.groups.isEmpty) {
                      return Center(child: Text('You have no invitations.'),);
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.groups.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Card(
                                elevation: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.6,
                                      child: Column(
                                        children: [
                                          Text('${state.groups[i].leaderName} has invited'),
                                          Text('you to group ${state.groups[i].name}', maxLines: 2),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        children: [
                                          BlocListener<NotificationBloc, NotificationState>(
                                            bloc: _notificationBloc,
                                            listener: (context, state) {
                                              if (state is NotificationStateSuccess) {
                                                if (state.isRejected) {

                                                } else {

                                                }
                                              }
                                              },
                                              child: IconButton(
                                                onPressed: (){
                                                  _notificationBloc.add(NotificationRejectEvent(familyId: state.groups[i].id));
                                                },
                                                icon: Icon(Icons.remove, color: Colors.red,),
                                              ),
                                              ),
                                          BlocListener<NotificationBloc, NotificationState>(
                                            bloc: _notificationBloc,
                                            listener: (context, state) {
                                              if (state is NotificationStateSuccess) {
                                                if (state.isAccepted) {

                                                } else {

                                                }
                                              }
                                            },
                                            child: IconButton(
                                              onPressed: (){
                                                _notificationBloc.add(NotificationAcceptEvent(familyId: state.groups[i].id));
                                              },
                                              icon: Icon(Icons.done, color: Colors.green,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          );
                        });
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _displayAcceptTopMotionToast(BuildContext context, int result) {
  //   switch (result) {
  //     case 1:
  //       MotionToast.error(
  //         title: "ERROR",
  //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
  //         description: "Create group is failure",
  //         animationType: ANIMATION.FROM_TOP,
  //         position: MOTION_TOAST_POSITION.CENTER,
  //         width: 300,
  //       ).show(context);
  //       break;
  //     case 0:
  //       MotionToast.success(
  //         title: "SUCCESS",
  //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
  //         description: "Create group is success",
  //         animationType: ANIMATION.FROM_TOP,
  //         position: MOTION_TOAST_POSITION.CENTER,
  //         width: 300,
  //       ).show(context);
  //       break;
  //   }
  // }
  //
  // _displayRejectTopMotionToast(BuildContext context, int result) {
  //   switch (result) {
  //     case 1:
  //       MotionToast.error(
  //         title: "ERROR",
  //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
  //         description: "Create group is failure",
  //         animationType: ANIMATION.FROM_TOP,
  //         position: MOTION_TOAST_POSITION.CENTER,
  //         width: 300,
  //       ).show(context);
  //       break;
  //     case 0:
  //       MotionToast.success(
  //         title: "SUCCESS",
  //         titleStyle: TextStyle(fontWeight: FontWeight.bold),
  //         description: "Create group is success",
  //         animationType: ANIMATION.FROM_TOP,
  //         position: MOTION_TOAST_POSITION.CENTER,
  //         width: 300,
  //       ).show(context);
  //       break;
  //   }
  // }
}
