import 'dart:io' as local;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/add_member_blocs.dart';
import 'package:personhealth/blocs/group_detail_blocs.dart';
import 'package:personhealth/blocs/group_blocs.dart';
import 'package:personhealth/events/add_member_events.dart';
import 'package:personhealth/events/group_detail_events.dart';
import 'package:personhealth/events/group_events.dart';
import 'package:personhealth/screens/haudq/group.dart';
import 'package:personhealth/states/group_detail_states.dart';

import 'add_member.dart';

class GroupDetail extends StatefulWidget {
  final String roleInGroup;
  final int familyId;
  final String name;
  final String image;

  const GroupDetail({required this.roleInGroup,
    required this.familyId,
    required this.name,
    required this.image});

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;
  late GroupDetailBloc _detailBloc;
  final _renameController = TextEditingController();

  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? imageT =
    (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50));
    local.File image = local.File(imageT!.path);
    _detailBloc.add(
        GroupDetailChangeAvatarEvent(familyId: widget.familyId, image: image));
  }

  @override
  void initState() {
    _detailBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _renameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;

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
              child: SingleChildScrollView(
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
                                itemCount: state.groupFamily.patients.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Container(
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
                                        child: ExpansionTile(
                                          title: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            height: height * 0.07,
                                            width: width * 0.9,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.grey,
                                                      backgroundImage: NetworkImage(
                                                          '${state.groupFamily
                                                              .patients[index]
                                                              .image}'),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: width * 0.6,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "${state.groupFamily
                                                        .patients[index].name}",
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
                                          children: [
                                            state.patients[index].hasLegal
                                                ? Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                                side: new BorderSide(
                                                    color: Colors.green.shade100,
                                                    width: 1.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.person),
                                                    title: Text(
                                                        'Personal information'),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                        'Date of birth: ${state
                                                            .patients[index].dob}'),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                        'Gender: ${state
                                                            .patients[index]
                                                            .gender}'),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                        'Phone: ${state
                                                            .patients[index]
                                                            .phone}'),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                        'Address: ${state
                                                            .patients[index]
                                                            .address}'),
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                        'Blood Type: ${state
                                                            .patients[index]
                                                            .bloodType}'),
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                                side: new BorderSide(
                                                    color: Colors.green.shade100,
                                                    width: 1.0),
                                              ),
                                              child: ListTile(
                                                leading: Icon(Icons.person),
                                                title:
                                                Text('Personal information'),
                                                subtitle: Text(
                                                    'This information has not been shared.'),
                                              ),
                                            ),
                                            state.patients[index].hasBody
                                                ? Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                                side: new BorderSide(
                                                    color: Colors.green.shade100,
                                                    width: 1.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.info),
                                                    title: Text('Body information'),
                                                  ),
                                                  ListTile(
                                                    title: state.patients[index]
                                                        .height != 0
                                                        ? Text(
                                                        'Height: ' +
                                                            state.patients[index]
                                                                .height.toString())
                                                        : Text('Height: '),
                                                  ),
                                                  ListTile(
                                                    title: state.patients[index]
                                                        .weight != 0
                                                        ? Text(
                                                        'Weight: ' +
                                                            state.patients[index]
                                                                .weight.toString())
                                                        : Text('Weight: '),
                                                  ),
                                                  ListTile(
                                                    title: state.patients[index]
                                                        .eyesight != 0 ? Text(
                                                        'Eyesight: ' +
                                                            state.patients[index]
                                                                .eyesight
                                                                .toString()) : Text(
                                                        'Eyesight: '),
                                                  ),
                                                ],
                                              ),
                                            ) : Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15.0),
                                                  side: new BorderSide(
                                                      color: Colors.green.shade100,
                                                      width: 1.0),
                                                ),
                                                child: ListTile(
                                                    leading: Icon(Icons.info),
                                                    title: Text('Body information'),
                                                    subtitle: Text(
                                                        'This information has not been shared.')
                                                ),
                                            ),
                                            state.patients[index].hasPreHistoric ? Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                                side: new BorderSide(
                                                    color: Colors.green.shade100,
                                                    width: 1.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Icon(Icons.medical_services),
                                                    title: Text('Medical history'),
                                                  ),
                                                  ListTile(
                                                    title: Text('Diseases'),
                                                    subtitle: Text(
                                                        '   ' + state.patients[index].getListDiseases()),
                                                  ),
                                                  ListTile(
                                                    title: Text('Allergies'),
                                                    subtitle: Text(
                                                        '   ' + state.patients[index].getListAllergies()),
                                                  ),
                                                  ListTile(
                                                    title: Text('Surgeries'),
                                                    subtitle: Text(
                                                        '   ' + state.patients[index].getListSurgeries()),
                                                  ),
                                                ],
                                              ),
                                            ) : Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                                side: new BorderSide(
                                                    color: Colors.green.shade100,
                                                    width: 1.0),
                                              ),
                                              child: ListTile(
                                                  leading: Icon(Icons.medical_services),
                                                  title: Text('Medical history'),
                                                  subtitle: Text('This information has not been shared.')
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
                        }),
                  ],
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => AddMemberBloc()..add(AddMemberFetchEvent()), child: AddMember(familyId: widget.familyId,),)));
                        },
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
                        onTap: () {
                          _showEditDialog(context, widget.familyId);
                        },
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
                        onTap: () {
                          _showRenameDialog(context, widget.familyId);
                        },
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
                        onTap: () {
                          _imgFromGallery();
                        },
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
                        onTap: () {
                          _showEditDialog(context, widget.familyId);
                        },
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
                        onTap: () {
                          _showRenameDialog(context, widget.familyId);
                        },
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
                        onTap: () {
                          _imgFromGallery();
                        },
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) =>
                                  GroupBloc()
                                    ..add(GroupFetchEvent()),
                                  child: ListGroup(
                                    name: widget.name,
                                    image: widget.image,
                                  ),
                                )));
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

  _showRenameDialog(BuildContext buildContext, int familyGroupId) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _renameGroup(familyGroupId);
        });
  }

  Widget _renameGroup(int familyGroupId) {
    return AlertDialog(
      title: Center(child: Text('Rename group')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        BlocListener(
          bloc: _detailBloc,
          listener: (context, state) {
            if (state is GroupDetailStateSuccess) {
              if (state.isRename) {
                _displayRenameTopMotionToast(context, 0);
              } else {
                _displayRenameTopMotionToast(context, 1);
              }
            }
          },
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              _detailBloc.add(GroupDetailRenameEvent(
                  familyInt: familyGroupId,
                  groupName: _renameController.text.trim()));
            },
            child: Text('Rename'),
          ),
        ),
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 50,
            child: Column(
              children: [
                TextField(
                  controller: _renameController..text = '',
                  decoration: InputDecoration(
                    hintText: "Group name",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.drive_file_rename_outline,
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
            ),
          );
        },
      ),
    );
  }

  _showEditDialog(BuildContext buildContext, int familyGroupId) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _editSharing(familyGroupId);
        });
  }

  Widget _editSharing(int familyGroupId) {
    return AlertDialog(
      title: Center(child: Text('Edit Sharing')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        BlocListener(
          bloc: _detailBloc,
          listener: (context, state) {
            if (state is GroupDetailStateSuccess) {
              if (state.isEdited) {
                _displayTopMotionToast(context, 0);
              } else {
                _displayTopMotionToast(context, 1);
              }
            }
          },
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              _detailBloc.add(GroupDetailEditEvent(
                  familyGroupId: familyGroupId,
                  bodyIndex: valueSecond,
                  legalInformation: valueFirst,
                  prehistoricInformation: valueThird));
            },
            child: Text('Edit'),
          ),
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

  _displayTopMotionToast(BuildContext context, int result) {
    switch (result) {
      case 1:
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Edit sharing is failed",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Edit sharing successfully",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }

  _displayRenameTopMotionToast(BuildContext context, int result) {
    switch (result) {
      case 1:
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Group renaming failed",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Successful group name change",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
