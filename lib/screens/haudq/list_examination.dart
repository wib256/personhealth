import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/examination_detail_blocs.dart';
import 'package:personhealth/blocs/list_examination_blocs.dart';
import 'package:personhealth/events/examination_detail_events.dart';
import 'package:personhealth/events/list_examination_events.dart';
import 'package:personhealth/screens/haudq/examination_detail.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';
import 'package:personhealth/states/list_examination_states.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ListExamination extends StatefulWidget {
  final String name;
  final String image;
  const ListExamination({required this.name, required this.image});

  @override
  State<ListExamination> createState() => _ListClinicState();
}

class _ListClinicState extends State<ListExamination> {
  late ListExaminationBloc _listExaminationBloc;

  String _range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('yyyy-MM-dd').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('yyyy-MM-dd')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
        print(_range);
        _listExaminationBloc.add(ListExaminationSearchEent(dateF: DateFormat('yyyy-MM-dd').format(args.value.startDate).toString(), dateT: DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate).toString()));
      }
    });
  }

  @override
  void initState() {
    _listExaminationBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return MasterLayout(
      title: 'All examination',
      image: '${widget.image}',
      name: '${widget.name}',
      child: Container(
        child: Column(
          children: [

            Padding(
              padding: EdgeInsets.all(10),
              child: ExpansionTile(
                title: ListTile(
                  title: Row(
                    children: [
                      Text('Search'),
                    ],
                  ),
                ),
                trailing: Icon(Icons.search),
                children:[
                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: width * 0.95,
                child: Column(
                  children: [
                    BlocBuilder<ListExaminationBloc, ListExaminationState>(
                        builder: (context, state) {
                      if (state is ListExaminationStateInitial) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ListExaminationStateFailure) {
                        return Center(
                          child: Text('Cannot connect to the system'),
                        );
                      }
                      if (state is ListExaminationStateSuccess) {
                        if (state.examinations.isEmpty) {
                          return Center(
                            child: Text('You do not have any examination'),
                          );
                        }
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.examinations.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) => ExaminationDetailBloc()..add(ExaminationDetailFetchEvent(examinationID: state.examinations[index].id, date: state.examinations[index].date)), child: ExaminationDetail(examination: state.examinations[index],),)));
                                  },
                                  child: Container(
                                    height: height * 0.20,
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
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/exam.png"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.local_hospital,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                                    color: Colors.cyan[800],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Text(
                                                      "${state.examinations[index].clinicName}",
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
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Icon(
                                                    Icons.date_range,
                                                    size: 18,
                                                    color: Colors.cyan[800],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${state.examinations[index].date}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          Colors.blueGrey[500],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.4,
                                                  ),
                                                  Text(
                                                    "view details",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Colors.cyan,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 15,
                                                    color: Colors.cyan,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ]),
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
            ),
          ],
        ),
      ),
    );
  }
}
