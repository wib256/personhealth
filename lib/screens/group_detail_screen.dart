import 'dart:io' as local;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personhealth/blocs/group_family_blocs.dart';
import 'package:personhealth/events/group_family_events.dart';
import 'package:personhealth/states/group_family_states.dart';

import 'home_screen.dart';

class GroupDetailScreen extends StatefulWidget {
  final int familyId;
  final String roleInGroup;
  final String groupName;

  const GroupDetailScreen(
      {Key? key,
      required this.familyId,
      required this.roleInGroup,
      required this.groupName})
      : super(key: key);

  @override
  _GroupDetailScreenState createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  late GroupFamilyBloc _groupFamilyBloc;
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;
  final _phoneController = TextEditingController();
  final _groupNameController = TextEditingController();

  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? imageT = (await picker.pickImage(source: ImageSource.gallery, imageQuality: 50));
    local.File image = local.File(imageT!.path);
    _groupFamilyBloc.add(GroupFamilyChangeImage(familyId: widget.familyId, image: image));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _groupFamilyBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _groupNameController.dispose();
  }

  PopupMenuButton getPopupMenuButton(BuildContext context) {
    if (widget.roleInGroup.compareTo('leader') == 0) {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _showAddDialog(context, widget.familyId);
                    },
                    child: ListTile(
                      leading: Icon(Icons.add),
                      title: Text('Add member'),
                    ),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _showEditDialog(context, widget.familyId);
                    },
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  value: 2,
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _showRenameDialog(context, widget.familyId);
                    },
                    child: ListTile(
                      leading: Icon(Icons.drive_file_rename_outline),
                      title: Text('Rename'),
                    ),
                  ),
                  value: 3,
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _imgFromGallery();
                    },
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Change avatar'),
                    ),
                  ),
                  value: 4,
                )
              ]);
    } else {
      return PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _showEditDialog(context, widget.familyId);
                    },
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _showRenameDialog(context, widget.familyId);
                    },
                    child: ListTile(
                      leading: Icon(Icons.drive_file_rename_outline),
                      title: Text('Rename'),
                    ),
                  ),
                  value: 2,
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      _imgFromGallery();
                    },
                    child: ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Change avatar'),
                    ),
                  ),
                  value: 3,
                )
              ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(index: 2)));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          getPopupMenuButton(context),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<GroupFamilyBloc, GroupFamilyState>(
                builder: (context, state) {
              if (state is GroupFamilyStateInitial) {
                return Center(
                  child: LinearProgressIndicator(),
                );
              } else if (state is GroupFamilyStateFailure) {
                return Center(
                  child: Expanded(
                      child: Text(
                          'The system is crashing, please try again later!')),
                );
              } else if (state is GroupFamilyStateSuccess) {
                if (state.groupFamily != null) {
                  if (state.groupFamily!.patients.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.groupFamily!.patients.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 16),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext buildContext, int index) {
                        return ExpansionTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('none'),
                                maxRadius: 20,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${state.groupFamily!.patients[index].name}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget.roleInGroup.compareTo('leader') == 0
                                  ? TextButton(
                                      onPressed: () {
                                        _groupFamilyBloc.add(
                                            GroupFamilyDeleteMember(
                                                familyId: widget.familyId,
                                                patientId: state.groupFamily!
                                                    .patients[index].id,
                                                index: index));
                                      },
                                      child: Text('Delete'))
                                  : Text(''),
                            ],
                          ),
                          children: [
                            state.listPatient.isNotEmpty &&
                                    state.listPatient[index].id != 0 &&
                                    state.listPatient[index].hasLegal == true
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text('Personal information'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Date of birth: ${state.listPatient[index].dob}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Gender: ${state.listPatient[index].gender}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Phone: ${state.listPatient[index].phone}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Address: ${state.listPatient[index].address}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Blood Type: ${state.listPatient[index].bloodType}'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.person),
                                          title: Text('Personal information'),
                                        ),
                                      ],
                                    ),
                                  ),
                            state.listPatient.isNotEmpty &&
                                    state.listPatient[index].id != 0 &&
                                    state.listPatient[index].hasBody == true
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.info),
                                          title: Text('Body information'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Height: ${state.listPatient[index].height}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Weight: ${state.listPatient[index].weight}'),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Eyesight: ${state.listPatient[index].eyesight}'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.info),
                                          title: Text('Body information'),
                                        ),
                                      ],
                                    ),
                                  ),
                            state.listPatient.isNotEmpty &&
                                    state.listPatient[index].id != 0 &&
                                    state.listPatient[index].hasPreHistoric ==
                                        true
                                ? Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.medical_services),
                                          title: Text('Medical history'),
                                        ),
                                        ListTile(
                                          title: Text('Allergic things'),
                                          subtitle: Text(
                                              '${state.listPatient[index].medicalNote}'),
                                          isThreeLine: true,
                                        ),
                                        ListTile(
                                          title: Text('Medical history'),
                                          subtitle: Text(
                                              '${state.listPatient[index].diseaseHealthRecordList.toString()}'),
                                        ),
                                      ],
                                    ),
                                  )
                                : Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: new BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.medical_services),
                                          title: Text('Medical history'),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('The group currently has no members'),
                    );
                  }
                } else {
                  return Center(
                    child: Text('The group has no members'),
                  );
                }
              }
              return Text('');
            })
          ],
        ),
      ),
    ));
  }

  _showAddSuccess(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            content: Text(
                'Add member successfully, wait for that person to accept the invitation.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  }

  _showRenameSuccess(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            content: Text('Rename successfully.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
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
        TextButton(
          onPressed: () {
            _groupFamilyBloc.add(GroupFamilyRename(
                familyId: widget.familyId,
                name: _groupNameController.value.text));
            Navigator.pop(context);
            _showRenameSuccess(context);
          },
          child: Text('Rename'),
        ),
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 50,
            child: Column(
              children: [
                TextField(
                  controller: _groupNameController,
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

  _showAddDialog(BuildContext buildContext, int familyGroupId) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _addMember(familyGroupId);
        });
  }

  Widget _addMember(int familyGroupId) {
    return AlertDialog(
      title: Center(child: Text('Add member')),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            _groupFamilyBloc.add(GroupFamilyAddMemberToGroup(
                familyGroupId: widget.familyId,
                phone: _phoneController.value.text,
                groupName: widget.groupName));
            Navigator.pop(context);
            _showAddSuccess(context);
          },
          child: Text('Add'),
        ),
      ],
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: 50,
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.phone,
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

  _showEditSuccess(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            content: Text('Edit successfully.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
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
        TextButton(
          onPressed: () {
            _groupFamilyBloc.add(GroupFamilyEditSharingToGroupEvent(
                familyGroupId: familyGroupId,
                bodyIndex: valueSecond,
                legalInformation: valueFirst,
                prehistoricInformation: valueThird));
            Navigator.pop(context);
            _showEditSuccess(context);
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
