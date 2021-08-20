import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/add_member_blocs.dart';
import 'package:personhealth/blocs/individual_blocs.dart';
import 'package:personhealth/events/add_member_events.dart';
import 'package:personhealth/events/individual_events.dart';
import 'package:personhealth/states/add_member_states.dart';

import '../information.dart';

class SharePatient extends StatefulWidget {
  const SharePatient({Key? key}) : super(key: key);

  @override
  _SharePatientState createState() => _SharePatientState();
}

class _SharePatientState extends State<SharePatient> {
  late AddMemberBloc _addMemberBloc;
  final _searchController = TextEditingController();
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;

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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => IndividualBloc()
                        ..add(IndividualFetchEvent()),
                      child: Information(),
                    )));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Text(
          'Share with other patients',
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
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.8,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.07,
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
                        ],
                      ),
                    ),
                    children: [
                      SizedBox(height: 10,),
                      Text('Please select the information you want to share:'),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 5,),
                      CheckboxListTile(
                        secondary: const Icon(Icons.person),
                        title: const Text('Basic information'),
                        subtitle: Text('name, date of birth, blood group,...'),
                        value: this.valueFirst,
                        onChanged: (bool? value) {
                          setState(() {
                            valueFirst = value!;
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
                            valueSecond = value!;
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
                            valueThird = value!;
                          });
                        },
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
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                _addMemberBloc.add(AddMemberShareEvent(phone: state.patient.phone, prehistoricInformation: valueThird, legalInformation: valueFirst, bodyIndex: valueSecond));
                              },
                              child: Text(
                                'Share', style: TextStyle(fontSize: 16),),
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
          description: "Patient sharing failed",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Successful sharing",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
