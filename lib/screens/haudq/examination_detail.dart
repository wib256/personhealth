import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ExaminationDetail extends StatefulWidget {
  @override
  _ExaminationDetailState createState() => _ExaminationDetailState();
}

class _ExaminationDetailState extends State<ExaminationDetail> {
  get color => null;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              width: double.infinity,
              height: height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Phòng Khám Đa Khoa DHA",
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
                    "09-08-2021 1:18 AM",
                    style: TextStyle(
                      fontSize: 12,
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
                        "Dignore",
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
                          "rat binh thuong kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh  kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh kagfkagfk  aufhkua kgahfkughakf kahfkahfk akfh"),
                      Text(
                        "Dignore",
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
                      Text("rat binh thuong kagfkagfkaaaaaaaaaa"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
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
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            child: Container(
                              height: height * 0.23,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                          "Khám mắt",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey[500],
                                            fontWeight: FontWeight.bold,
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
                                                color: Colors.grey.shade300),
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
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("120 - 320"),
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
                                                color: Colors.grey.shade300),
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
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("220"),
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
                                          child: Text("--"),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: height * 0.23,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                          "Khám mũi",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey[500],
                                            fontWeight: FontWeight.bold,
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
                                                color: Colors.grey.shade300),
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
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("120 - 320"),
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
                                          color: Colors.red[200],
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade300),
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
                                          color: Colors.red[200],
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("420"),
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
                                          child: Text("--"),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
    title: 'Phòng Khám Đa Khoa DHA',
    message: 'Thank you for your feedback',
    submitButton: 'Submit',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, '
          'comment: ${response.comment}');
    },
  );

  showDialog(
    context: context,
    barrierDismissible: true, 
    builder: (context) => _ratingDialog,
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
                  onTap: () {},
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
}
