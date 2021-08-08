import 'package:personhealth/blocs/draw_graph_blocs.dart';

class DrawGraphFetchEvent extends DrawGraphBloc {
  final int testId;
  final double min;
  final double max;
  DrawGraphFetchEvent({required this.testId, required this.min, required this.max});
}

class DrawGraphExpandGraphEvent extends DrawGraphBloc {
  final double max;
  DrawGraphExpandGraphEvent({required this.max});
}