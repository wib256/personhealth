import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/draw_graph_events.dart';
import 'package:personhealth/repositorys/examination_detail_respository.dart';
import 'package:personhealth/states/draw_graph_states.dart';

class DrawGraphBloc extends Bloc<DrawGraphBloc, DrawGraphState> {
  DrawGraphBloc() : super(DrawGraphStateInitial());

  @override
  Stream<DrawGraphState> mapEventToState(DrawGraphBloc event) async* {
    if (event is DrawGraphFetchEvent) {
      final listGraphData = await getDataForGraph(event.testId);
      double maxData = 0;
      if (listGraphData.isNotEmpty) {
        //create label X
        List<String> labelX = [];
        List<double> data = [];
        for (int i = 0; i < listGraphData.length; i++) {
          if (maxData < listGraphData[i].result) {
            maxData = listGraphData[i].result;
          }
        }
        //The default value returned is a list of length 5. Label X is date
        if (listGraphData.length >= 5) {
          for (int i = listGraphData.length - 5; i < listGraphData.length; i++) {
            String label = listGraphData[i].date.day.toString() + '-' + listGraphData[i].date.month.toString();
            labelX.add(label);
            if (event.min == -9999) {
              if (listGraphData[i].result / event.max == 1) {
                data.add(0.5);
              } else {
                data.add(1);
              }
            } else {
              data.add(listGraphData[i].result / maxData);
            }
          }
        } else { //if less than 5 will return the length of the list based on the length returned by the api.
          for (int i =0; i < listGraphData.length; i++) {
            String label = listGraphData[i].date.day.toString() + '-' + listGraphData[i].date.month.toString();
            labelX.add(label);
            if (event.min == -9999) {
              if (listGraphData[i].result / event.max == 1) {
                data.add(0.5);
              } else {
                data.add(1);
              }
            } else {
              data.add(listGraphData[i].result / event.max);
            }
          }
        }

        //Label y has a constant length of 5. Divide into 5 equal parts.
        if (event.min == -9999) {
          var labelY = ['Negative', 'Position'];
          yield DrawGraphStateSuccess(data: data, labelX: labelX, labelY: labelY, graphData: listGraphData);
        } else {
          double plus = maxData / 5;
          var labelY = [(plus).toString(), (plus * 2).toString(), (plus * 3).toString(), maxData.toString()];

          //return yield success
          yield DrawGraphStateSuccess(data: data, labelX: labelX, labelY: labelY, graphData: listGraphData);
        }

      } else {
        yield DrawGraphStateFailure();
      }
    } else if (event is DrawGraphExpandGraphEvent) {
      var currentState = state as DrawGraphStateSuccess;
      
      //Add labelX, data
      if (currentState.graphData.length > 5) {
        for (int i = 5; i < currentState.graphData.length && i < 10; i++) {
          //add labelX
          String label = currentState.graphData[i].date.day.toString() + '-' + currentState.graphData[i].date.month.toString();
          currentState.labelX.add(label);
          
          //add data
          currentState.data.add(currentState.graphData[i].result / event.max);
        }

        yield currentState;
      } else {
        yield currentState;
      }
    }
  }
}