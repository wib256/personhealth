import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DrawGraph extends StatelessWidget {
  final int testId;
  final double min;
  final double max;
  final String testName;

  const DrawGraph(
      {Key? key, required this.testId, required this.min, required this.max, required this.testName})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: darkBlue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("DrawGraph Package"),
        ),
        body: MyScreen(),
      ),
    );
  }
}

class MyScreen extends StatelessWidget {

  final List<Feature> features = [
    Feature(
      title: "Drink Water",
      color: Colors.blue,
      data: [0.1, 0.8, 0.4, 0.7, 0.6, 0.7],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 64.0),
          child: Text(
            "Tasks Track",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        LineGraph(
          features: features,
          size: Size(320, 400),
          labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
          labelY: ['10', '40', '60', '80', '100'],
          showDescription: true,
          graphColor: Colors.white30,
          graphOpacity: 0.2,
          verticalFeatureDirection: true,
          descriptionHeight: 130,
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}