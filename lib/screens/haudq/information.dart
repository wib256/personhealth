import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/individual_blocs.dart';
import 'package:personhealth/events/individual_events.dart';
import 'package:personhealth/states/individual_states.dart';

/// This is the stateless widget that the main application instantiates.
class Information extends StatefulWidget {
  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  late IndividualBloc _individualBloc;
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;

  @override
  void initState() {
    _individualBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey[500],
          ),
        ),
        backgroundColor: Color(0xffcef4e8),
        title: Text(
          "Individual",
          style: TextStyle(
              color: Colors.blueGrey[500],
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Material(
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
                      child: Text('Share with me',
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Tab(
                      child: Text('My sharing',
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share,
                                      color: Colors.blueGrey,
                                      size: height * 0.04)),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          BlocBuilder<IndividualBloc, IndividualState>(
                              builder: (context, state) {
                            if (state is IndividualStateInitial) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is IndividualStateFailure) {
                              return Center(
                                child: Text('Unable to connect to the system.'),
                              );
                            }
                            if (state is IndividualStateSuccess) {
                              if (state.listShared.isEmpty) {
                                return Center(
                                  child: Text(
                                      'You are currently not shared by anyone.'),
                                );
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.listShared.length,
                                  itemBuilder: (context, i) {
                                    return Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          width: width * 0.95,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.green.shade100,
                                                  blurRadius: 20)
                                            ],
                                          ),
                                          child: ExpansionTile(
                                            title: Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
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
                                                        backgroundImage:
                                                            NetworkImage(
                                                                '${state.listShared[i].image}'),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    width: width * 0.6,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${state.listShared[i].name}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors
                                                            .blueGrey[500],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            children: [
                                              state.listShared[i].hasLegal
                                                  ? Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: new BorderSide(
                                                            color: Colors
                                                                .green.shade100,
                                                            width: 1.0),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.person),
                                                            title: Text(
                                                                'Personal information'),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Date of birth: ${state.listShared[i].dob}'),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Gender: ${state.listShared[i].gender}'),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Address: ${state.listShared[i].address}'),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Blood Type: ${state.listShared[i].bloodType}'),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: new BorderSide(
                                                            color: Colors
                                                                .green.shade100,
                                                            width: 1.0),
                                                      ),
                                                      child: ListTile(
                                                        leading:
                                                            Icon(Icons.person),
                                                        title: Text(
                                                            'Personal information'),
                                                        subtitle: Text(
                                                            'This information has not been shared.'),
                                                      ),
                                                    ),
                                              state.listShared[i].hasBody
                                                  ? Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: new BorderSide(
                                                            color: Colors
                                                                .green.shade100,
                                                            width: 1.0),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(
                                                                Icons.info),
                                                            title: Text(
                                                                'Body information'),
                                                          ),
                                                          ListTile(
                                                            title: state
                                                                        .listShared[
                                                                            i]
                                                                        .height !=
                                                                    0
                                                                ? Text('Height: ' +
                                                                    state
                                                                        .listShared[
                                                                            i]
                                                                        .height
                                                                        .toString())
                                                                : Text(
                                                                    'Height: '),
                                                          ),
                                                          ListTile(
                                                            title: state
                                                                        .listShared[
                                                                            i]
                                                                        .weight !=
                                                                    0
                                                                ? Text('Weight: ' +
                                                                    state
                                                                        .listShared[
                                                                            i]
                                                                        .weight
                                                                        .toString())
                                                                : Text(
                                                                    'Weight: '),
                                                          ),
                                                          ListTile(
                                                            title: state
                                                                        .listShared[
                                                                            i]
                                                                        .eyesight !=
                                                                    0
                                                                ? Text('Eyesight: ' +
                                                                    state
                                                                        .listShared[
                                                                            i]
                                                                        .eyesight
                                                                        .toString())
                                                                : Text(
                                                                    'Eyesight: '),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: new BorderSide(
                                                            color: Colors
                                                                .green.shade100,
                                                            width: 1.0),
                                                      ),
                                                      child: ListTile(
                                                          leading:
                                                              Icon(Icons.info),
                                                          title: Text(
                                                              'Body information'),
                                                          subtitle: Text(
                                                              'This information has not been shared.')),
                                                    ),
                                              state.listShared[i].hasPreHistoric
                                                  ? Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                        side: new BorderSide(
                                                            color: Colors
                                                                .green.shade100,
                                                            width: 1.0),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Icon(Icons
                                                                .medical_services),
                                                            title: Text(
                                                                'Medical history'),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Diseases'),
                                                            subtitle: Text('   ' +
                                                                state
                                                                    .listShared[
                                                                        i]
                                                                    .getListDiseases()),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Allergies'),
                                                            subtitle: Text('   ' +
                                                                state
                                                                    .listShared[
                                                                        i]
                                                                    .getListAllergies()),
                                                          ),
                                                          ListTile(
                                                            title: Text(
                                                                'Surgeries'),
                                                            subtitle: Text('   ' +
                                                                state
                                                                    .listShared[
                                                                        i]
                                                                    .getListSurgeries()),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Card(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Text('Other state');
                          }),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          BlocBuilder<IndividualBloc, IndividualState>(
                              builder: (context, state) {
                            if (state is IndividualStateInitial) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is IndividualStateFailure) {
                              return Center(
                                child: Text('Unable to connect to the system.'),
                              );
                            }
                            if (state is IndividualStateSuccess) {
                              return ListView.builder(
                                  itemCount: state.listSharing.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        width: width * 0.95,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.green.shade100,
                                                blurRadius: 20)
                                          ],
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          height: height * 0.07,
                                          width: width * 0.9,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
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
                                                        '${state.listSharing[i].image}'),
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
                                                  "${state.listSharing[i].name}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blueGrey[500],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Center(
                                                child: IconButton(
                                                    onPressed: () {
                                                      _showEditDialog(context,
                                                          state.listSharing[i].id);
                                                    },
                                                    icon: Icon(Icons.edit)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Center(
                              child: Text('Other state'),
                            );
                          }),
                        ],
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
        BlocListener(
          bloc: _individualBloc,
          listener: (context, state) {
            if (state is IndividualStateSuccess) {
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
              _individualBloc.add(IndividualEditEvent(
                  patientId: patientId,
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
}
