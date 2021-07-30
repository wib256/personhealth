import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/events/patient_events.dart';
import 'package:personhealth/states/patient_states.dart';

class SharingPatient extends StatefulWidget {
  const SharingPatient({Key? key}) : super(key: key);

  @override
  _SharingPatientState createState() => _SharingPatientState();
}

class _SharingPatientState extends State<SharingPatient> {
  final _searchController = TextEditingController();
  late PatientBloc _patientBloc;
  late bool valueFirst = false;
  late bool valueSecond = false;
  late bool valueThird = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _patientBloc = BlocProvider.of(context);
    _patientBloc.add(PatientFetchEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    _patientBloc.add(PatientSearchEvent(phone: value));
                  },
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
              BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
                if (state is PatientStateInitial) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('Enter phone number to search'),
                  );
                } else if (state is PatientStateFailure) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text('The system is currently unresponsive'),
                  );
                } else if (state is PatientStateSuccess) {
                  if (state.patient.id != 0) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "${state.patient.name}",
                                      style: TextStyle(color: Colors.blue, fontSize: 20),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Image.network('${state.patient.image}', errorBuilder: (context, exception ,stracktrace) {
                                        return Image.network('https://static2.yan.vn/YanNews/2167221/202102/facebook-cap-nhat-avatar-doi-voi-tai-khoan-khong-su-dung-anh-dai-dien-e4abd14d.jpg');
                                      },),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  ExpansionTile(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      'Create',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    children: [
                                      Text('Please select the information you want to share:'),
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
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: TextButton(
                                          onPressed: () {
                                            _patientBloc.add(PatientSharingEvent(bodyIndex: valueSecond, legalInformation: valueFirst, prehistoricInformation: valueThird, phoneOfSharedPatient: _searchController.value.text));
                                            _showShareSuccess(context);
                                          },
                                          child: Text('Create', style: TextStyle(fontSize: 16),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              elevation: 5,
                            ),
                          ],
                        )
                    );
                  } else {
                    return Text('Enter phone number to search');
                  }

                }
                return Text('');
              }),
            ],
          ),
        ),
      ),
    ));
  }

  _showShareSuccess(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return AlertDialog(content: Text('Successfully shared'),);
        });
  }

}
