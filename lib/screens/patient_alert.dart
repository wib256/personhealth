import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/states/patient_states.dart';

class PatientSharing extends StatefulWidget {
  const PatientSharing({Key? key}) : super(key: key);

  @override
  _PatientSharingState createState() => _PatientSharingState();
}

class _PatientSharingState extends State<PatientSharing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
              if (state is PatientStateInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PatientStateFailure) {
                return Center(
                  child: Text(
                      'The system is having a problem, the information cannot be accessed.'),
                );
              }
              if (state is PatientStateSuccess) {
                return Column(
                  children: [
                    state.patient.hasLegal
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
                                      'Date of birth: ${state.patient.dob}'),
                                ),
                                ListTile(
                                  title:
                                      Text('Gender: ${state.patient.gender}'),
                                ),
                                // ListTile(
                                //   title: Text('Phone: ${state.patient.phone}'),
                                // ),
                                ListTile(
                                  title:
                                      Text('Address: ${state.patient.address}'),
                                ),
                                ListTile(
                                  title: Text(
                                      'Blood Type: ${state.patient.bloodType}'),
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
                                  subtitle: Text(
                                      'Information is not allowed to be shared.'),
                                ),
                              ],
                            ),
                          ),
                    state.patient.hasBody
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
                                  title: state.patient.height != 0 ? Text(
                                      'Height: ' +  state.patient.height.toString()) : Text('Height: '),
                                ),
                                ListTile(
                                  title: state.patient.weight != 0 ? Text(
                                      'Weight: ' +  state.patient.weight.toString()) : Text('Weight: '),
                                ),
                                ListTile(
                                  title: state.patient.eyesight != 0 ? Text(
                                      'Eyesight: ' +  state.patient.eyesight.toString()) : Text('Eyesight: '),
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
                                  subtitle: Text(
                                      'Information is not allowed to be shared.'),
                                ),
                              ],
                            ),
                          ),
                    state.patient.hasPreHistoric
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
                                // ListTile(
                                //   title: Text('Allergic things'),
                                //   subtitle:
                                //       Text('${state.patient.medicalNote}'),
                                //   isThreeLine: true,
                                // ),
                                ListTile(
                                  title: Text('Medical history'),
                                  subtitle: Text('${state.patient.diseaseHealthRecordList.toString()}'),
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
                                  subtitle: Text(
                                      'Information is not allowed to be shared.'),
                                ),
                              ],
                            ),
                          ),
                  ],
                );
              }
              return Text('');
            })
          ],
        ),
      ),
    );
  }
}
