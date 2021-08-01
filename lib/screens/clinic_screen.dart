import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/clinic_blocs.dart';
import 'package:personhealth/events/clinic_events.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/states/clinic_states.dart';

import 'card_clinic_widget.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late ClinicBloc _clinicBloc;
  late Clinic selectClinic;
  final ScrollController _scrollController = ScrollController();
  final _searchClinicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clinicBloc = BlocProvider.of(context);
    _clinicBloc.add(ClinicFetchEvent());
  }

  void onTapClinic(Clinic clinic) {
    this.setState(() {
      this.selectClinic = clinic;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _searchClinicController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: TextField(
                controller: _searchClinicController,
                onSubmitted: (value) {
                  _clinicBloc.add(ClinicSearchEvent(search: _searchClinicController.text));
                },
                decoration: InputDecoration(
                  labelText: 'Search by district',
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: new BorderSide(
                    color: Colors.blue, width: 1.0),
              ),
              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
            BlocBuilder<ClinicBloc, ClinicState>(
              builder: (context, state) {
                if (state is ClinicStateInitial) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ClinicStateFailure) {
                  return Center(
                    child: Text(
                      'Cannot load clinics from Server',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  );
                }
                if (state is ClinicStateSuccess) {
                  if (state.clinics.isEmpty) {
                    return Center(child: Text('No result!'));
                  }
                  return ListView.builder(
                    itemBuilder: (BuildContext buildContext, int index) {
                      if (index >= state.clinics.length) {
                        return Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          ),
                        );
                      } else {
                        return Card2(clinic: state.clinics[index],);
                      }
                    },
                    itemCount: state.clinics.length,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  );
                }
                return Center(child: Text('Other states..'));
              },
            ),
          ],
        ),
      ),
    );
  }
}


