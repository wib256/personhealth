import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personhealth/models/clinic.dart';

class Card2 extends StatelessWidget {
  final Clinic clinic;
  Card2({required this.clinic});

  @override
  Widget build(BuildContext context) {
    buildImg(Color color, double height) {
      return SizedBox(
          height: height,
          child: Container(
            color: color,
           child: Center(
             child: Image.network("${clinic.image}", errorBuilder: (context, exception, stracktrace) {
               return Image.network('https://brandspurng.com/wp-content/uploads/2019/03/hospital_green.jpg');
             }),
           ),
          ));
    }

    buildCollapsed1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${clinic.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ]);
    }

    buildCollapsed2() {
      return buildImg(Colors.grey, 200);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${clinic.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ]);
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.grey[300],
            child: Center(
              child: Image.network('${clinic.image}', errorBuilder: (context, exception, stracktrace) {
               return Image.network('https://brandspurng.com/wp-content/uploads/2019/03/hospital_green.jpg');
              }),
            ),
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hotline: ${clinic.phone}',
              softWrap: true,
            ),
            Text(
              'Location: ${clinic.address}',
              softWrap: true,
            ),
            Text(
              'Description: ${clinic.description}',
              softWrap: true,
            ),
          ],
        ),
      );
    }

    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: ScrollOnExpand(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: new BorderSide(
                    color: Colors.blue, width: 1.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expandable(
                    collapsed: buildCollapsed1(),
                    expanded: buildExpanded1(),
                  ),
                  Expandable(
                    collapsed: buildCollapsed2(),
                    expanded: buildExpanded2(),
                  ),
                  Expandable(
                    collapsed: buildCollapsed3(),
                    expanded: buildExpanded3(),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Builder(
                        builder: (context) {
                          var controller =
                          ExpandableController.of(context, required: true)!;
                          return TextButton(
                            child: Text(
                              controller.expanded ? "COLLAPSE" : "EXPAND",
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.deepPurple),
                            ),
                            onPressed: () {
                              controller.toggle();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}