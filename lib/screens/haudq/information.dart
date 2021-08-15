import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class Information extends StatefulWidget {
  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blueGrey[500],
          ),
        ),
        backgroundColor: Color(0xffcef4e8),
        title: Text(
          "Individual",
          style: TextStyle(
              color: Colors.blueGrey[500],
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Material(
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text('My sharing',
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Tab(
                      child: Text('Share with me',
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.share, color: Colors.blueGrey, size: height * 0.04)),
                              SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              height: height * 0.07,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.green.shade100,
                                      blurRadius: 20)
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            ''),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    width: width * 0.6,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Lươn Văn Nhật",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueGrey[500],
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  Center(
                                    child: IconButton(
                                        onPressed: (){},
                                        icon: Icon(Icons.edit)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Container(
                            width: width * 0.95,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.green.shade100,
                                    blurRadius: 20)
                              ],
                            ),
                            child: ExpansionTile(
                              title: Container(
                                padding: EdgeInsets.only(left: 10),
                                height: height * 0.07,
                                width: width * 0.9,

                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              ''),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      width: width * 0.6,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Đào Văn Nhật",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blueGrey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              children: [
                                Text('A'),
                                Text('A'),
                                Text('A'),
                                Text('A'),
                                Text('A'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
