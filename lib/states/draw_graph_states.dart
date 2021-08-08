import 'dart:core';

import 'package:personhealth/models/graph_data.dart';

class DrawGraphState {
  const DrawGraphState();
}

class DrawGraphStateInitial extends DrawGraphState{}
class DrawGraphStateFailure extends DrawGraphState{}
class DrawGraphStateSuccess extends DrawGraphState{
  final List<double> data;
  final List<String> labelX;
  final List<String> labelY;
  final List<GraphData> graphData;
  DrawGraphStateSuccess({required this.data, required this.labelX, required this.labelY, required this.graphData});
}