import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:personhealth/blocs/clinic_detail_blocs.dart';
import 'package:personhealth/models/comment.dart';
import 'package:personhealth/states/clinic_detail_states.dart';

class ClinicDetail extends StatefulWidget {
  @override
  _ClinicDetailState createState() => _ClinicDetailState();
}

class _ClinicDetailState extends State<ClinicDetail> {
  late ClinicDetailBloc _clinicDetailBloc;
  get color => null;

  @override
  void initState() {
    _clinicDetailBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: BlocBuilder<ClinicDetailBloc, ClinicDetailStates>(
              builder: (context, state) {
                if (state is ClinicDetailStateFailure) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/clinic.png'),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.26,
                  );
                }
                if (state is ClinicDetailStateInitial) {
                  return Container(
                    child: CircularProgressIndicator(),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.26,
                  );
                }
                if (state is ClinicDetailStateSuccess) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${state.clinic.image}'),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.26,
                  );
                }
                return Text('Other state');
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(25),
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: BlocBuilder<ClinicDetailBloc, ClinicDetailStates>(
                  builder: (context, state) {
                    if (state is ClinicDetailStateFailure) {
                      return Expanded(
                          child: Center(
                            child: Text('Cannot connect to the system'),
                          ));
                    }
                    if (state is ClinicDetailStateInitial) {
                      return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    }
                    if (state is ClinicDetailStateSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.clinic.name}",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RatingBarIndicator(
                            rating: state.rate,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 25,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Text(
                                    'About us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${state.clinic.description}',
                                    style: TextStyle(
                                      height: 1.4,
                                      color: Colors.blueGrey.withOpacity(0.7),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Reviews',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  _listComments(context, state.comments)
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text('Other state');
                  }),
            ),
          ),
          Positioned(child: _buildAppBar(), top: 0, left: 0, right: 0),
        ],
      ),
    );
  }

  Container _listComments(BuildContext context, List<Comment> comment) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: comment.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            shadowColor: Colors.green[100],
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "${comment[index].image}"),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${comment[index].name}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text("${comment[index].time}"),
                      RatingBarIndicator(
                        rating: comment[index].rate,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            "${comment[index].comment}",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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
                    "Clinic details",
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
}
