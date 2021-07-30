import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:personhealth/blocs/examination_blocs.dart';
import 'package:personhealth/blocs/examination_detail_bloc.dart';
import 'package:personhealth/events/examination_detail_events.dart';
import 'package:personhealth/events/examination_events.dart';
import 'package:personhealth/models/rating.dart';
import 'package:personhealth/screens/examination_detail_screen.dart';
import 'package:personhealth/states/examination_states.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({Key? key}) : super(key: key);

  @override
  _ExaminationScreenState createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  late ExaminationBloc _examinationBloc;
  late int selectIndex;
  DateTime currentDate = DateTime.now();
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();
  bool isDateFrom = false;
  bool isDateTo = false;
  int lengthOfListExamination = 0;
  late double ratingPoint;
  final _commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _examinationBloc = BlocProvider.of(context);
    _examinationBloc.add(ExaminationFetchEvent());
    ratingPoint = 3;
  }

  void onTapIndex(int index) {
    this.setState(() {
      this.selectIndex = index;
    });
  }

  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2020),
        lastDate:
            DateTime(currentDate.year, currentDate.month, currentDate.day));
    if (picked != null)
      _dateFromController.text = "${picked.toLocal()}".split(' ')[0];
    setState(() {
      isDateFrom = true;
    });
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2020),
        lastDate:
            DateTime(currentDate.year, currentDate.month, currentDate.day));
    if (picked != null)
      _dateToController.text = "${picked.toLocal()}".split(' ')[0];
    setState(() {
      isDateTo = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dateFromController.dispose();
    _dateToController.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      _selectDateFrom(context);
                    },
                    child: TextField(
                      controller: _dateFromController,
                      decoration: InputDecoration(
                        labelText: 'Date from',
                        icon: Icon(
                          Icons.date_range, color: Colors.blue,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: GestureDetector(
                    onTap: () {
                      _selectDateTo(context);
                    },
                    child: TextField(
                      controller: _dateToController,
                      decoration: InputDecoration(
                        labelText: 'Date to',
                        icon: Icon(
                          Icons.date_range, color: Colors.blue
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      enabled: false,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isDateTo == true && isDateFrom == true) {
                      _examinationBloc.add(ExaminationSearchEvent(
                          dateT: _dateToController.value.text,
                          dateF: _dateFromController.value.text));
                    }
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 0,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: BlocBuilder<ExaminationBloc, ExaminationState>(
                builder: (context, state) {
                  if (state is ExaminationStateInitial) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ExaminationStateFailure) {
                    return Center(
                      child: Text(
                        'Cannot load examinations from Server',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    );
                  }
                  if (state is ExaminationStateSuccess) {
                    if (state.examinations.isEmpty) {
                      return Center(
                          child: Text('You do not have examination !'));
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext buildContext, int index) {
                        lengthOfListExamination = state.examinations.length;
                        if (index >= state.examinations.length) {
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
                            color: Colors.blue[50],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: new BorderSide(
                                  color: Colors.blue, width: 1.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                onTapIndex(state.examinations[index].id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  ExaminationDetailExpandBloc()
                                                    ..add(
                                                        ExaminationDetailExpandFetchEvent(
                                                            this.selectIndex,
                                                            state
                                                                .examinations[
                                                                    index]
                                                                .date)),
                                              child: ExaminationDetailScreen(),
                                            )));
                              },
                              child: ListTile(
                                leading: Icon(Icons.description),
                                title: Text('Test',
                                    style: TextStyle(fontSize: 20)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Clinic: ${state.examinations[index].clinicName}'),
                                    Text(
                                        'Date: ${state.examinations[index].date}'),
                                    Text(
                                        'Result: ${state.examinations[index].diagnose}'),
                                    Text(
                                        'Advise: ${state.examinations[index].advise}'),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (state.examinations[index]
                                                      .rateStatus !=
                                                  'enable' &&
                                              state.examinations[index]
                                                      .rateStatus !=
                                                  'expire') {
                                            _showRateDialog(buildContext,
                                                state.examinations[index].id);
                                          }
                                        },
                                        child: state.examinations[index]
                                                    .rateStatus ==
                                                'enable'
                                            ? Text("Rated")
                                            : state.examinations[index]
                                                        .rateStatus ==
                                                    'expire'
                                                ? Text("Expired")
                                                : Text("Rate"),
                                        style: state.examinations[index]
                                                        .rateStatus !=
                                                    'enable' &&
                                                state.examinations[index]
                                                        .rateStatus !=
                                                    'expire'
                                            ? ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.blue, // background
                                                onPrimary:
                                                    Colors.white, // foreground
                                              )
                                            : ElevatedButton.styleFrom(
                                                primary:
                                                    Colors.grey, // background
                                                onPrimary:
                                                    Colors.white, // foreground
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      itemCount: state.examinations.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                  return Center(child: Text('Other states..'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRateDialog(BuildContext buildContext, int examinationId) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return _rateClinic(examinationId);
        });
  }

  Widget _rateClinic(int examinationId) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text('Rating for this examination'),
            Divider(
              color: Colors.grey,
              height: 20,
              thickness: 0.5,
              indent: 20,
              endIndent: 0,
            ),
            RatingBar.builder(
              initialRating: 3,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                }
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              },
              onRatingUpdate: (rating) {
                ratingPoint = rating;
                print(rating);
              },
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        TextButton(
            onPressed: () {
              Rating rating = new Rating(
                  '',
                  _commentController.value.text,
                  examinationId,
                  ratingPoint,
                  'enable',
                  currentDate.toString(),
                  currentDate.toString());
              _examinationBloc.add(ExaminationRateEvent(rating: rating));
              Navigator.pop(context);
            },
            child: Text('Ok')),
      ],
    );
  }
}
