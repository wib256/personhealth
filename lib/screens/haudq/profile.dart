import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool readLegal = true;
  bool readMedical = true;
  bool readBody = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //---------address
    var addressController =
        new TextEditingController(text: "147 Hoàng Văn Thụ");
    var bloodController = new TextEditingController(text: "A");
    var dobController = new TextEditingController(text: "1998/01/01");
    //---------body

    var heightController = new TextEditingController(text: "175 cm");
    var weightController = new TextEditingController(text: "85 kg");
    var eyesightController = new TextEditingController(text: "10");

    //---------medical
    var diseaseController = new TextEditingController(
        text:
            "Thoái hóa cột sống Thoái hóa cột sốngThoái hóa cột sốngThoái hóa cột sốngThoái hóa cột sốngThoái hóa cột sống");
    var surgeryController =
        new TextEditingController(text: "Mổ thoát vị đĩa đệm");
    var allergieController =
        new TextEditingController(text: "Dị ứng với bí đao");

    return MasterLayout(
      title: "Profile",
      name: '',
      image: "",
      child: Container(
        width: width,
        height: height - 100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/phrsystem-a595c.appspot.com/o/5656dbb2-d9ad-4245-87fe-0f492bcd7b7f.jpg?alt=media",
                      ),
                      radius: width * 0.13,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lươn Văn Nhật",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 25,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Center(
                              child: Icon(
                                Icons.phone,
                                size: 18,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Center(
                              child: Text(
                                "0936588854",
                                style: TextStyle(
                                  height: height * 0.002,
                                  color: Colors.blueGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Icon(
                                Icons.male,
                                size: 18,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Center(
                              child: Text(
                                "Male",
                                style: TextStyle(
                                  height: height * 0.002,
                                  color: Colors.blueGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Legal information",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  readLegal
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readLegal = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readLegal = true;
                                // thuc hien cap nhat
                              });
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        ),
                ],
              ),
              Container(
                width: width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.green.shade100,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowInformation(
                        "Address", addressController, readLegal),
                    _buildRowInformation(
                        "Blood type", bloodController, readLegal),
                    _buildRowInformation(
                        "Date of birth", dobController, readLegal),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Body index",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  readBody
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readBody = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readBody = true;
                                // thuc hien cap nhat
                              });
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        ),
                ],
              ),
              Container(
                width: width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.green.shade100,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowInformation("Height", heightController, readBody),
                    _buildRowInformation("Weight", weightController, readBody),
                    _buildRowInformation(
                        "Eyesight", eyesightController, readBody),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Medical history",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  readMedical
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readMedical = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                readMedical = true;
                                // thuc hien cap nhat
                              });
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.blueGrey,
                              size: 18,
                            ),
                          ),
                        ),
                ],
              ),
              Container(
                width: width,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.green.shade100,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowInformation(
                        "Disease history", diseaseController, readMedical),
                    _buildRowInformation(
                        "History surgery", surgeryController, readMedical),
                    _buildRowInformation(
                        "Allergies", allergieController, readMedical),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRowInformation(
      String title, TextEditingController editingController, bool read) {
    var addController = new TextEditingController();
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              readOnly: read,
              controller: editingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 18,
              ),
              onChanged: (value) {},
              maxLines: 1,
            ),
          ),
        ),
        !read
            ? IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contex) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: Center(
                        child: Text(
                          "Add $title",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextField(
                                        controller: addController,
                                        onChanged: (value) {
                                          // update ket qua vao list state tam thoi
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            addController.text = "";
                                            //reset khung nhap
                                          });
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  Text("list da add")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.add, color: Colors.blueGrey),
              )
            : SizedBox(),
      ],
    );
  }
}
