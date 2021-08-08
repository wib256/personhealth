import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/examination_detail_bloc.dart';
import 'package:personhealth/screens/draw_graph.dart';
import 'package:personhealth/states/examination_detail_states.dart';

class ExaminationDetailScreen extends StatefulWidget {

  const ExaminationDetailScreen(
      {Key? key})
      : super(key: key);

  @override
  _ExaminationDetailScreenState createState() =>
      _ExaminationDetailScreenState();
}

class _ExaminationDetailScreenState extends State<ExaminationDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Health'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Material(
          child: Column(
            children: [
              BlocBuilder<ExaminationDetailExpandBloc,
                  ExaminationDetailExpandState>(builder: (context, state) {
                if (state is ExaminationDetailStateInitial) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ExaminationDetailStateInitial) {
                  return Center(
                    child: Text(
                      'Cannot load examination detail from Server',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  );
                }
                if (state is ExaminationDetailStateSuccess) {
                  if (state.list.isEmpty) {
                    return Center(child: Text('Currently no test results!'));
                  } else {
                    return ListView.builder(
                      itemBuilder: (BuildContext buildContext, int index) {
                        if (index >= state.list.length) {
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
                          return Card(
                            color: ((state.list[index].result <=
                                            state.list[index].indexValueMax &&
                                        state.list[index].result >=
                                            state.list[index].indexValueMin) ||
                                    (state.list[index].result == -9999))
                                ? Colors.green[50]
                                : Colors.red[50],
                            elevation: 10,
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (state.list[index].result == -9999 || state.list[index].result == 9999) {
                                  _showAlertWarning();
                                } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DrawGraph(testId: state.list[index].testID, min: state.list[index].indexValueMin, max: state.list[index].indexValueMax, testName: state.list[index].testName,)));
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                        'Content: ${state.list[index].testName}'),
                                    leading:
                                        Icon(Icons.drive_file_rename_outline),
                                    subtitle: Text(
                                        'Diagnose: ${state.list[index].diagnose}'),
                                  ),
                                  Table(
                                    border: TableBorder.symmetric(),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                color: Colors.green[400],
                                                child: Text(
                                                  'Standard',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15),
                                                )),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                color: Colors.green[400],
                                                child: Text(
                                                  'This time',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15),
                                                )),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.orange[300],
                                                ),
                                                child: Text(
                                                  'Last',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 15),
                                                )),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                child: state.list[index]
                                                            .indexValueMin ==
                                                        -9999
                                                    ? Text(
                                                        'Negative',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    : Text(
                                                        '${state.list[index].indexValueMin} - ${state.list[index].indexValueMax}',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                child: state.list[index]
                                                            .indexValueMin ==
                                                        -9999
                                                    ? (state.list[index].result ==
                                                            9999
                                                        ? Text(
                                                            'Positive',
                                                            textAlign:
                                                                TextAlign.center,
                                                          )
                                                        : Text(
                                                            'Negative',
                                                            textAlign:
                                                                TextAlign.center,
                                                          ))
                                                    : Text(
                                                        '${state.list[index].result}',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                          ),
                                          TableCell(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            child: Container(
                                                height: 30,
                                                child: state.list[index]
                                                            .indexValueMin ==
                                                        -9999
                                                    ? (state.list[index]
                                                                .lastResul ==
                                                            9999
                                                        ? Text(
                                                            'Positive',
                                                            textAlign:
                                                                TextAlign.center,
                                                          )
                                                        : Text(
                                                            'Negative',
                                                            textAlign:
                                                                TextAlign.center,
                                                          ))
                                                    : state.list[index]
                                                                .lastResul !=
                                                            0
                                                        ? Text(
                                                            '${state.list[index].lastResul}',
                                                            textAlign:
                                                                TextAlign.center,
                                                          )
                                                        : Text(
                                                            'None',
                                                            textAlign:
                                                                TextAlign.center,
                                                          )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: state.list.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                }
                return Center(child: Text('Other states..'));
              }),
            ],
          ),
        ),
      ),
    );
  }

  _showAlertWarning() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text('Cancel clicks', textAlign: TextAlign.center,)
      );
    });
  }
}
