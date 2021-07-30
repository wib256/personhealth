import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/events/group_event.dart';
import 'package:personhealth/events/patient_events.dart';
import 'package:personhealth/models/group.dart';
import 'package:personhealth/screens/conservation_list.dart';
import 'package:personhealth/screens/sharing_patient_screen.dart';
import 'package:personhealth/states/group_states.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late GroupBloc _groupBloc;
  late String groupName = '';
  final _searchPatientController = TextEditingController();
  final _groupNameController = TextEditingController();
  late List<Group> listInvitedGroup;
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _groupBloc = BlocProvider.of(context);
    _groupBloc.add(GroupFetchEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchPatientController.dispose();
    _groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.group,
                        color: Colors.black,
                      ),
                      child:
                          Text('Group', style: TextStyle(color: Colors.black)),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.privacy_tip,
                        color: Colors.black,
                      ),
                      child: Text('Private share',
                          style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Group",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 2),
                                height: 30,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(30),
                                //   color: Colors.blue[50],
                                // ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue[50],
                                      ),
                                      height: 30,
                                      child: GestureDetector(
                                        onTap: () {
                                          _showCreateDialog(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.pink,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "Create",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue[50],
                                      ),
                                      height: 30,
                                      child: BlocBuilder<GroupBloc, GroupState>(
                                        builder: (context, state) {
                                          if (state is GroupStateSuccess) {
                                            if (state.listInvitedGroup.isNotEmpty) {
                                              return GestureDetector(
                                                onTap: () {
                                                  listInvitedGroup = state.listInvitedGroup;
                                                  _showNotiDialog(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.notifications_active,
                                                      color: Colors.pink,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      "Notification",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          }
                                          return SizedBox(width: 0,);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: TextField(
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
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                            ),
                          ),
                        ),
                        BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                          if (state is GroupStateInitial) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (state is GroupStateFailure) {
                            return Center(
                              child: Text(
                                'Cannot load groups from Server',
                                style:
                                    TextStyle(fontSize: 22, color: Colors.red),
                              ),
                            );
                          }
                          if (state is GroupStateSuccess) {
                            if (state.listGroup.isEmpty) {
                              return Center(
                                child: Text(
                                  'You have not joined any groups yet',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.red),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: state.listGroup.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 16),
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext buildContext, int index) {
                                  return ConservationList(
                                      userFamilyGroup: state.listGroup[index]);
                                },
                              );
                            }
                          }
                          return Text('');
                        }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Private Sharing",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 2),
                                height: 30,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(30),
                                //   color: Colors.blue[50],
                                // ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue[50],
                                      ),
                                      height: 30,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocProvider(
                                                        create: (context) =>
                                                            PatientBloc()
                                                              ..add(
                                                                  PatientFetchEvent()),
                                                        child: SharingPatient(),
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.pink,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "Share",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
                          child: TextField(
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
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade100)),
                            ),
                          ),
                        ),
                        BlocBuilder<GroupBloc, GroupState>(
                            builder: (context, state) {
                          if (state is GroupStateInitial) {
                            return Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                          if (state is GroupStateFailure) {
                            return Expanded(
                                child: Center(
                              child: Text(
                                'Cannot load groups from Server',
                                style:
                                    TextStyle(fontSize: 22, color: Colors.red),
                              ),
                            ));
                          }
                          if (state is GroupStateSuccess) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Card(
                                  margin: EdgeInsets.all(5),
                                  elevation: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Shared',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        height: 20,
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 0,
                                      ),
                                      state.listShared.length == 0 ? Center(child: Text('None'),) :
                                      ListView.builder(
                                          itemCount: state.listShared.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: 16),
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext buildContext,
                                              int index) {
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                          NetworkImage(state
                                                              .listShared[
                                                          index]
                                                              .image),
                                                          maxRadius: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  state
                                                                      .listShared[
                                                                  index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      16),
                                                                ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.all(5),
                                  elevation: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Sharing',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                        height: 20,
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 0,
                                      ),
                                      state.listSharing.length == 0 ? Center(child: Text('None'),) :
                                      ListView.builder(
                                          itemCount: state.listSharing.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(top: 16),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext buildContext,
                                                  int index) {
                                            return Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(state
                                                                  .listSharing[
                                                                      index]
                                                                  .image),
                                                          maxRadius: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  state
                                                                      .listSharing[
                                                                          index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                SizedBox(
                                                                  height: 6,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              _showEditDialog(context, state.listSharing[index].id);
                                                            },
                                                            child: Text('Edit')),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return Expanded(
                            child: Text(''),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  _showNotiDialog(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Center(child:  Text('Invitation list'),),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          itemCount: listInvitedGroup.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext buildContext, int index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${listInvitedGroup[index].leaderName}'),
                                  TextButton(
                                    onPressed: () {
                                      _groupBloc.add(GroupAcceptEvent(familyId: listInvitedGroup[index].id));
                                      listInvitedGroup.removeAt(index);
                                    },
                                    child: Text('Accept'),
                                  ),
                                ],

                              );
                            })
                      ],
                    ),
                  ),
                );
              }
          ),
          actions: [
            TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Close')),
          ],
        );
    });
  }

  _showCreateDialog(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _createGroup();
        });
  }

  Widget _createGroup() {
    return AlertDialog(
      title: Center(child: Text('Create new Group')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            groupName = _groupNameController.value.text;
            _groupBloc.add(GroupCreateEvent(groupName: groupName));
            Navigator.pop(context);
          },
          child: Text('Create'),
        ),
      ],
      content: ConstrainedBox(
          constraints: new BoxConstraints(
            maxHeight: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  hintText: "Group name",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.group,
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
            ],
          )),
    );
  }

  _showEditDialog(BuildContext buildContext, int patientId) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _editSharing(patientId);
        });
  }

  Widget _editSharing(int patientId) {
    return AlertDialog(
      title: Center(child: Text('Edit Sharing')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            _groupBloc.add(PrivateEditEvent(patientId: patientId, bodyIndex: valueSecond, legalInformation: valueFirst, prehistoricInformation: valueThird));
            Navigator.pop(context);
          },
          child: Text('Edit'),
        ),
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 200,
            child: Column(
              children: [
                CheckboxListTile(
                  secondary: const Icon(Icons.person),
                  title: const Text('Basic information'),
                  subtitle: Text('name, date of birth, blood group,...'),
                  value: this.valueFirst,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valueFirst = value!;
                    });
                  },

                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  secondary: const Icon(Icons.info),
                  title: const Text('Body information'),
                  subtitle: Text('height, weight, eyesight,...'),
                  value: this.valueSecond,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valueSecond = value!;
                      print(this.valueSecond);
                    });
                  },

                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  secondary: const Icon(Icons.medical_services),
                  title: const Text('Medical history'),
                  subtitle: Text('diseases that have been acquired'),
                  value: this.valueThird,
                  onChanged: (bool? value) {
                    setState(() {
                      this.valueThird = value!;
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
