import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/examination_detail_blocs.dart';
import 'package:personhealth/events/examination_detail_events.dart';
import 'package:personhealth/models/examination.dart';
import 'package:personhealth/models/rating.dart';
import 'package:personhealth/screens/draw_graph.dart';
import 'package:personhealth/states/examination_detail_states.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ExaminationDetail extends StatefulWidget {
  final Examination examination;

  const ExaminationDetail({required this.examination});

  @override
  _ExaminationDetailState createState() => _ExaminationDetailState();
}

class _ExaminationDetailState extends State<ExaminationDetail> {
  get color => null;
  late ExaminationDetailBloc _examinationDetailBloc;

  @override
  void initState() {
    _examinationDetailBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              width: double.infinity,
              height: height * 0.3,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.examination.clinicName}",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueGrey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _showRatingAppDialog();
                          },
                          icon: Image.asset(
                            "assets/img/rating.png",
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Date: ${widget.examination.date}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Diagnose",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.blueGrey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "  ${widget.examination.diagnose}",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "Advice",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.blueGrey[500],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "  ${widget.examination.advise}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3 + 100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "All test",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueGrey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<ExaminationDetailBloc,
                                  ExaminationDetailState>(
                              builder: (context, state) {
                            if (state is ExaminationDetailExpandStateInitial) {
                              return Container(
                                height: height * 0.23,
                                width: width,
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ExaminationDetailExpandStateFailure) {
                              return Container(
                                height: height * 0.23,
                                width: width,
                                child: Center(
                                  child:
                                      Text('Unable to connect to the system'),
                                ),
                              );
                            }
                            if (state is ExaminationDetailStateSuccess) {
                              if (state.list.isEmpty) {
                                return Container(
                                  height: height * 0.23,
                                  width: width,
                                  child: Center(
                                    child: Text('No examination results yet'),
                                  ),
                                );
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: state.list.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => DrawGraph(testId: state.list[index].testID, min: state.list[index].indexValueMin, max: state.list[index].indexValueMax, testName: state.list[index].testName)));
                                      },
                                      child: Card(
                                        child: Container(
                                          height: height * 0.23,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: width,
                                                color: Color(0xffcef4e8),
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Text(
                                                      "${state.list[index].testName}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Colors.blueGrey[500],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text("Standard"),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: state.list[index]
                                                                  .indexValueMin ==
                                                              -9999
                                                          ? Text("Negative")
                                                          : Text(
                                                              "${state.list[index].indexValueMin} - ${state.list[index].indexValueMax}"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text("This time"),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    decoration: BoxDecoration(
                                                      color: ((state.list[index]
                                                                          .result <=
                                                                      state
                                                                          .list[
                                                                              index]
                                                                          .indexValueMax &&
                                                                  state
                                                                          .list[
                                                                              index]
                                                                          .result >=
                                                                      state
                                                                          .list[
                                                                              index]
                                                                          .indexValueMin) ||
                                                              (state.list[index]
                                                                      .result ==
                                                                  -9999))
                                                          ? Colors.white
                                                          : Colors.red.shade200,
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey.shade300),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: state.list[index]
                                                                  .result ==
                                                              -9999
                                                          ? Text("Negative")
                                                          : state.list[index]
                                                                      .result ==
                                                                  9999
                                                              ? Text("Positive")
                                                              : Text(
                                                                  "${state.list[index].result}"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    child: Center(
                                                      child: Text("Last"),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.5 - 10,
                                                    height: height * 0.082 - 20,
                                                    child: Center(
                                                      child: state.list[index]
                                                                  .indexValueMin ==
                                                              -9999
                                                          ? (state.list[index]
                                                                      .lastResul ==
                                                                  9999
                                                              ? Text(
                                                                  'Positive',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )
                                                              : Text(
                                                                  'Negative',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ))
                                                          : state.list[index]
                                                                      .lastResul !=
                                                                  0
                                                              ? Text(
                                                                  '${state.list[index].lastResul}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                )
                                                              : Text(
                                                                  '--',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return Text('');
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(child: _buildAppBar(), top: 0, left: 0, right: 0),
        ],
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: '${widget.examination.clinicName}',
      message: 'Thank you for your feedback',
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        _examinationDetailBloc.add(ExaminationDetailRateEvent(
            rating: new Rating(
                widget.examination.clinicName,
                response.comment,
                widget.examination.id,
                double.parse(response.rating.toString()),
                'enable',
                DateTime.now().toString(),
                DateTime.now().toString())));
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BlocListener<ExaminationDetailBloc, ExaminationDetailState>(
        bloc: _examinationDetailBloc,
        listener: (context, state) {
          if (state is ExaminationDetailStateSuccess) {
            if (state.isRated) {
              _displayTopMotionToast(context, 0);
            } else {
              _displayTopMotionToast(context, 1);
            }
          }
        },
        child: _ratingDialog,
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
                    Navigator.pop(context);
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
                    "Examination details",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _displayTopMotionToast(BuildContext context, int opt) {
    switch (opt) {
      case 0:
        MotionToast.success(
          title: "SUCCESS",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          animationType: ANIMATION.FROM_BOTTOM,
          width: 300,
          description: 'You have rated the clinic successfully.',
        ).show(context);
        break;
      case 1:
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "You have rated the clinic unsuccessfully.",
          animationType: ANIMATION.FROM_BOTTOM,
          width: 300,
        ).show(context);
        break;
    }
  }
}
