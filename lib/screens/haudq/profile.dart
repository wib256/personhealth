import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personhealth/blocs/profile_blocs.dart';
import 'package:personhealth/events/profile_events.dart';
import 'package:personhealth/screens/haudq/layout/master_layout.dart';
import 'package:personhealth/states/profile_states.dart';
import 'dart:io';


class Profile extends StatefulWidget {
  final String name;
  final String image;

  const Profile({required this.name, required this.image});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ProfileBloc _profileBloc;
  String img = '';
  bool readLegal = true;
  bool readMedical = true;
  bool readBody = true;
  final picker = ImagePicker();
  final addressController = TextEditingController();
  final bloodController = TextEditingController();
  final dobController = TextEditingController();

  //---------body

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final eyesightController = TextEditingController();

  //---------medical
  final diseaseController = TextEditingController();
  final surgeryController = TextEditingController();
  final allergiesController = TextEditingController();

  @override
  void initState() {
    img = widget.image;
    print('Image ne: ' + img);

    _profileBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    bloodController.dispose();
    dobController.dispose();
    heightController.dispose();
    weightController.dispose();
    eyesightController.dispose();
    diseaseController.dispose();
    surgeryController.dispose();
    allergiesController.dispose();
    super.dispose();
  }

  _imgFromGallery() async {
    XFile? imageT = await picker.pickImage(source: ImageSource.gallery,  imageQuality: 50);
    File image = File(imageT!.path);
    _profileBloc.add(ProfileUpdateImageEvent(image: image));

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //---------address

    return MasterLayout(
      title: "Profile",
      name: '${widget.name}',
      image: img,
      child: Container(
        width: width,
        height: height - 100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: width * 0.35,
                    child: InkWell(
                      onTap: () {
                        _imgFromGallery();

                      },
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileStateInitial) {
                              return CircleAvatar(
                                backgroundImage: AssetImage("assets/disease.png"),
                                radius: width * 0.13,
                              );
                            }
                            if (state is ProfileStateFailure) {
                              return CircleAvatar(
                                backgroundImage: AssetImage("assets/disease.png"),
                                radius: width * 0.13,
                              );
                            }
                            if (state is ProfileStateSuccess) {
                              if (state.patient.image.isEmpty) {
                                return CircleAvatar(
                                  backgroundImage: AssetImage("assets/disease.png"),
                                  radius: width * 0.13,
                                );
                              }
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "${state.patient.image}",
                                ),
                                radius: width * 0.13,
                              );
                            }
                            return CircleAvatar(
                              backgroundImage: AssetImage("assets/disease.png"),
                              radius: width * 0.13,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileStateInitial) {
                      return CircularProgressIndicator();
                    }
                    if (state is ProfileStateFailure) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.6,
                                    child: Text(
                                      "...",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
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
                                    "...",
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
                                    "...",
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
                      );
                    }
                    if (state is ProfileStateSuccess) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: width * 0.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.6,
                                    child: Text(
                                      "${state.patient.name}",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
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
                                    "${state.patient.phone}",
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
                                    "${state.patient.gender}",
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
                      );
                    }
                    return SizedBox();
                  }),
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
                                _profileBloc.add(ProfileUpdateLegalEvent(address: addressController.text, bloodType: bloodController.text, dob: dobController.text));
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
                child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileStateInitial) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Address", addressController, readLegal, ''),
                        _buildRowInformation(
                            "Blood type", bloodController, readLegal, ''),
                        _buildRowInformation(
                            "Date of birth", dobController, readLegal, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateFailure) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Address", addressController, readLegal, ''),
                        _buildRowInformation(
                            "Blood type", bloodController, readLegal, ''),
                        _buildRowInformation(
                            "Date of birth", dobController, readLegal, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateSuccess) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Address",
                            addressController,
                            readLegal, '${state.patient.address}'),
                        _buildRowInformation(
                            "Blood type",
                            bloodController,
                            readLegal, '${state.patient.bloodType}'),
                        _buildRowInformation(
                            "Date of birth",
                            dobController,
                            readLegal, '${state.patient.dob}',)
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildRowInformation(
                          "Address", addressController, readLegal, ''),
                      _buildRowInformation(
                          "Blood type", bloodController, readLegal, ''),
                      _buildRowInformation(
                          "Date of birth", dobController, readLegal, ''),
                    ],
                  );
                }),
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
                                _profileBloc.add(ProfileUpdateBodyEvent(height: heightController.text, weight: weightController.text, eyesight: eyesightController.text));
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
                child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileStateInitial) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Height", heightController, readBody, ''),
                        _buildRowInformation(
                            "Weight", weightController, readBody, ''),
                        _buildRowInformation(
                            "Eyesight", eyesightController, readBody, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateFailure) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Height", heightController, readBody, ''),
                        _buildRowInformation(
                            "Weight", weightController, readBody, ''),
                        _buildRowInformation(
                            "Eyesight", eyesightController, readBody, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateSuccess) {
                    return Column(
                      children: [
                        _buildRowInformation(
                            "Height",
                            heightController,
                            readBody, '${state.patient.height}'),
                        _buildRowInformation(
                            "Weight",
                            weightController,
                            readBody, '${state.patient.weight}'),
                        _buildRowInformation(
                            "Eyesight",
                            eyesightController,
                            readBody, '${state.patient.eyesight}'),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildRowInformation(
                          "Height", heightController, readBody, ''),
                      _buildRowInformation(
                          "Weight", weightController, readBody, ''),
                      _buildRowInformation(
                          "Eyesight", eyesightController, readBody, ''),
                    ],
                  );
                }),
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
                                _profileBloc.add(ProfileUpdateMedicalEvent(diseaseList: diseaseController.text, surgeryList: surgeryController.text, allergyList: allergiesController.text));
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
                child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                  if (state is ProfileStateInitial) {
                    return Column(
                      children: [
                        _buildRowMedicalHistory(
                            "Disease history", diseaseController, readMedical, ''),
                        _buildRowMedicalHistory(
                            "History surgery", surgeryController, readMedical, ''),
                        _buildRowMedicalHistory(
                            "Allergies", allergiesController, readMedical, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateFailure) {
                    return Column(
                      children: [
                        _buildRowMedicalHistory(
                            "Disease history", diseaseController, readMedical, ''),
                        _buildRowMedicalHistory(
                            "History surgery", surgeryController, readMedical, ''),
                        _buildRowMedicalHistory(
                            "Allergies", allergiesController, readMedical, ''),
                      ],
                    );
                  }
                  if (state is ProfileStateSuccess) {
                    return Column(
                      children: [
                        _buildRowMedicalHistory(
                            "Disease history",
                            diseaseController,
                            readMedical, '${state.patient.getListDiseases()}'),
                        _buildRowMedicalHistory(
                            "History surgery",
                            surgeryController,
                            readMedical, '${state.patient.getListSurgeries()}'),
                        _buildRowMedicalHistory(
                            "Allergies",
                            allergiesController,
                            readMedical, '${state.patient.getListAllergies()}'),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _buildRowMedicalHistory(
                          "Disease history", diseaseController, readMedical, ''),
                      _buildRowMedicalHistory(
                          "History surgery", surgeryController, readMedical, ''),
                      _buildRowMedicalHistory(
                          "Allergies", allergiesController, readMedical, ''),
                    ],
                  );
                }),
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
      String title, TextEditingController editingController, bool read, String hintValue) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                readOnly: read,
                controller: editingController,
                decoration: InputDecoration(
                  hintText: hintValue,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
                onTap: () {
                  editingController..text = hintValue;
                },
                onSubmitted: (value) {
                  editingController..text = value;
                },
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row _buildRowMedicalHistory(
      String title, TextEditingController editingController, bool read, String hintValue) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "$title: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    readOnly: read,
                    controller: editingController,
                    decoration: InputDecoration(
                      hintText: hintValue,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                    onTap: () {
                      editingController..text = hintValue;
                    },
                    onSubmitted: (value) {
                      editingController.text = value;
                    },
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
