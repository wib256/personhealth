import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/draw_graph_blocs.dart';
import 'package:personhealth/events/draw_graph_events.dart';
import 'package:personhealth/states/draw_graph_states.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DrawGraph extends StatelessWidget {
  final int testId;
  final double min;
  final double max;
  final String testName;

  const DrawGraph(
      {Key? key,
      required this.testId,
      required this.min,
      required this.max,
      required this.testName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffcef4e8),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Text(
            "DrawGraph",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: BlocProvider(
          create: (context) => DrawGraphBloc()
            ..add(DrawGraphFetchEvent(testId: testId, min: min, max: max)),
          child: MyScreen(
            min: min,
            max: max,
            testName: testName,
          ),
        ),
      ),
    );
  }
}

class MyScreen extends StatelessWidget {
  final double min;
  final double max;
  final String testName;

  MyScreen({required this.min, required this.max, required this.testName});

  final List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.greenAccent,
      data: [0.1, 0.8, 0.4, 0.7, 0.6, 0.7],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawGraphBloc, DrawGraphState>(
        builder: (context, state) {
      if (state is DrawGraphStateSuccess) {
        features[0].title = testName;
        features[0].data.clear();
        features[0].data = state.data;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "Result Track",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              LineGraph(
                features: features,
                size: Size(320, 400),
                labelX: state.labelX,
                labelY: state.labelY,
                showDescription: true,
                graphColor: Colors.black38,
                graphOpacity: 0.2,
                verticalFeatureDirection: true,
                descriptionHeight: 130,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: Color(0xffcef4e8),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "$testName",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.082 - 20,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Center(
                        child: Text("Standard"),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.082 - 20,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Center(
                        child:
                            min == -9999 ? Text("Negative") : Text("$min - $max"),
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.graphData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height:
                                MediaQuery.of(context).size.height * 0.082 - 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Center(
                              child: Text("${state.graphData[index].date.day}/${state.graphData[index].date.month}/${state.graphData[index].date.year}"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height:
                                MediaQuery.of(context).size.height * 0.082 - 20,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Center(
                              child: state.graphData[index].result == -9999
                                  ? Text("Negative")
                                  : state.graphData[index].result == 9999
                                      ? Text("Positive")
                                      : Text("${state.graphData[index].result}"),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        );
      }

      return SizedBox();
    });
    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     SizedBox(height: 20,),
    //     Container(),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 5.0),
    //       child: Text(
    //         "Result Track",
    //         style: TextStyle(
    //           fontSize: 28,
    //           fontWeight: FontWeight.bold,
    //           letterSpacing: 2,
    //           color: Colors.blueGrey,
    //         ),
    //       ),
    //     ),
    //     LineGraph(
    //       features: features,
    //       size: Size(320, 400),
    //       labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
    //       labelY: ['10', '40', '60', '80', '100'],
    //       showDescription: true,
    //       graphColor: Colors.black38,
    //       graphOpacity: 0.2,
    //       verticalFeatureDirection: true,
    //       descriptionHeight: 130,
    //     ),
    //     Text('Test'),
    //   ],
    // );
  }
}
