import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class clinicDetail extends StatefulWidget {
  @override
  _clinicDetailState createState() => _clinicDetailState();
}

class _clinicDetailState extends State<clinicDetail> {
  get color => null;
  var list = [
    'k',
    'a',
    'b'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/phrsystem-a595c.appspot.com/o/67fb7e78-90ab-4a0f-a756-8fa2648db2d7.jpg?alt=media"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.26,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.26,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              padding: EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * 0.74,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Phòng Khám Đa Khoa DHA",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(
                    height: 50,
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
                            'Là Phòng khám Đa khoa cao cấp theo chuẩn mực quốc tế góp phần nâng cao chất lượng chăm sóc sức khỏe cộng đồng. Tại DHA Healthcare, khách hàng được chăm sóc theo tiêu chuẩn tốt nhất với đội ngũ Bác sỹ trong và ngoài nước chuyên môn cao, giàu kinh nghiệm; hệ thống trang thiết bị y khoa chất lượng cao, được nhập khẩu từ các nước tiên tiến; hệ thống quản lý chất lượng dịch vụ ứng dụng công nghệ hiện đại nhằm đem đến trải nghiệm dịch vụ y tế chất lượng cao.',
                            style: TextStyle(
                              height: 1.6,
                              color: Colors.blueGrey.withOpacity(0.7),
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Interviews',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.4,
                            child: ListView.builder(itemBuilder: (context, index) {
                              var item = list[index];
                              return Text(item);
                            }, itemCount: list.length),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            child: _buildAppBar(),
            top: 0,
            left: 0,
            right: 0
          ),
        ],
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