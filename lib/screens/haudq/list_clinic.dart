import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/clinic_detail_blocs.dart';
import 'package:personhealth/blocs/list_clinic_blocs.dart';
import 'package:personhealth/events/clinic_detail_event.dart';
import 'package:personhealth/events/list_clinic_events.dart';
import 'package:personhealth/screens/haudq/clinic_details.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';
import 'package:personhealth/states/list_clinic_states.dart';

class ListClinic extends StatefulWidget {
  final String name;
  final String image;
  const ListClinic({required this.name, required this.image});

  @override
  State<ListClinic> createState() => _ListClinicState();
}

class _ListClinicState extends State<ListClinic> {
  late ListClinicBloc _listClinicBloc;
  final _searchClinic = TextEditingController();

  @override
  void initState() {
    _listClinicBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchClinic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MasterLayout(
        title: 'All clinic',
        name: '${widget.name}',
        image: '${widget.image}',
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Theme(
                    child: TextField(
                      controller: _searchClinic,
                      onSubmitted: (value) {
                        _listClinicBloc.add(ListClinicSearchEvent(searchClinic: _searchClinic.text));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        fillColor: Color(0xFFF2F4F5),
                        hintStyle: new TextStyle(color: Colors.grey[600]),
                        hintText: "What address of clinic want to search",
                      ),
                      autofocus: false,
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: Colors.grey[600],
                    )),
              ),
              BlocBuilder<ListClinicBloc, ListClinicState>(
                  builder: (context, state) {
                if (state is ListClinicStateInitial) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ListClinicStateFailure) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Expanded(
                      child: Center(
                        child: Text('Cannot connect to the system'),
                      ),
                    ),
                  );
                }
                if (state is ListClinicStateSuccess) {
                  if (state.clinics.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Expanded(
                        child: Center(
                          child: Text('No results were found'),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.clinics.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  BlocProvider(create: (context) => ClinicDetailBloc()..add(ClinicDetailFetchEvent(clinic: state.clinics[index])), child: ClinicDetail(),)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "${state.clinics[index].image}"),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${state.clinics[index].name}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueGrey[500],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 20),
                                      child: Icon(
                                        Icons.phone,
                                        size: 17,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Text(
                                      "${state.clinics[index].phone}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey[500]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 20),
                                      child: Icon(
                                        Icons.location_pin,
                                        size: 17,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "${state.clinics[index].address}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blueGrey[500]),
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
                return Text('Other State');
              }),
            ],
          ),
        ));
  }
}
