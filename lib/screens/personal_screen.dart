import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/events/patient_events.dart';
import 'package:personhealth/states/patient_states.dart';
import 'dart:io';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late PatientBloc _patientBloc;
  final _nameController = TextEditingController();
  late bool isEditName = false;
  late FocusNode myFocusNodeName;
  final _dobController = TextEditingController();
  late bool isEditDob = false;
  late FocusNode myFocusNodeDob;
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  late bool isEditAddress = false;
  late FocusNode myFocusNodeAddress;
  final _bloodTypeController = TextEditingController();
  late bool isEditBloodType = false;
  late FocusNode myFocusNodeBloodType;
  final _heightController = TextEditingController();
  late bool isEditHeight = false;
  late FocusNode myFocusNodeHeight;
  final _weightController = TextEditingController();
  late bool isEditWeight = false;
  late FocusNode myFocusNodeWeight;
  final _eyesightController = TextEditingController();
  late bool isEditEyesight = false;
  late FocusNode myFocusNodeEyesight;
  final _medicalNoteController = TextEditingController();


  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? imageT = await picker.pickImage(source: ImageSource.gallery,  imageQuality: 50);
    File image = File(imageT!.path);
    _patientBloc.add(PatientEditAvatarEvent(image: image));
  }

  Widget buildImage(String imagePath) {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          height: 200,
          child: InkWell(onTap: () {
            print('Click Edit');
          }),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bloodTypeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _eyesightController.dispose();
    _medicalNoteController.dispose();
    myFocusNodeName.dispose();
    myFocusNodeDob.dispose();
    myFocusNodeAddress.dispose();
    myFocusNodeBloodType.dispose();
    myFocusNodeHeight.dispose();
    myFocusNodeWeight.dispose();
    myFocusNodeEyesight.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _patientBloc = BlocProvider.of(context);
    myFocusNodeName = FocusNode();
    myFocusNodeDob = FocusNode();
    myFocusNodeAddress = FocusNode();
    myFocusNodeBloodType = FocusNode();
    myFocusNodeHeight = FocusNode();
    myFocusNodeWeight = FocusNode();
    myFocusNodeEyesight = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child:
            BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
          if (state is PatientStateInitial) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Container(
                    child: LinearProgressIndicator(),
                  ),
                ),
                Material(
                  child: TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.info,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.medical_services,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Icon(Icons.person),
                      Icon(Icons.info),
                      Icon(Icons.medical_services),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is PatientStateFailure) {
            return Text('Fail');
          } else if (state is PatientStateSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200,
                  color: Colors.grey.withOpacity(0.2),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.network(
                          '${state.patient.image}',
                          errorBuilder: (context, exception, stracktrace) {
                            return Image.network(
                                'https://static2.yan.vn/YanNews/2167221/202102/facebook-cap-nhat-avatar-doi-voi-tai-khoan-khong-su-dung-anh-dai-dien-e4abd14d.jpg');
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: buildCircle(
                              child: IconButton(
                                onPressed: () {
                                  _imgFromGallery();
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              all: 0,
                              color: Colors.grey.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  color: Colors.blue[50],
                  child: TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.info,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.medical_services,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditName = true;
                                        });
                                        myFocusNodeName.requestFocus();
                                      },
                                      icon: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _nameController
                                    ..text = state.patient.name,
                                  decoration: null,
                                  enabled: isEditName,
                                  focusNode: myFocusNodeName,
                                  onSubmitted: (value) {
                                    setState(() {
                                      isEditName = false;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date of birth',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditDob = true;
                                        });
                                        myFocusNodeDob.requestFocus();
                                      },
                                      icon: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _dobController
                                    ..text = state.patient.dob,
                                  decoration: null,
                                  enabled: isEditDob,
                                  focusNode: myFocusNodeDob,
                                  onSubmitted: (value) {
                                    setState(() {
                                      isEditDob = false;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 40,)
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _genderController
                                    ..text = state.patient.gender,
                                  decoration: null,
                                  enabled: false,
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Phone',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 40,)
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _phoneController
                                    ..text = state.patient.phone,
                                  decoration: null,
                                  enabled: false,
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditAddress = true;
                                        });
                                        myFocusNodeAddress.requestFocus();
                                      },
                                      icon: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _addressController
                                    ..text = state.patient.address,
                                  decoration: null,
                                  enabled: isEditAddress,
                                  focusNode: myFocusNodeAddress,
                                  onSubmitted: (value) {
                                    setState(() {
                                      isEditAddress = false;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              Divider(),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Blood Type',
                                      style: TextStyle(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditBloodType = true;
                                        });
                                        myFocusNodeBloodType.requestFocus();
                                      },
                                      icon: Icon(Icons.edit),
                                    )
                                  ],
                                ),
                                subtitle: TextField(
                                  controller: _bloodTypeController
                                    ..text = state.patient.bloodType,
                                  decoration: null,
                                  enabled: isEditBloodType,
                                  focusNode: myFocusNodeBloodType,
                                  onSubmitted: (value) {
                                    setState(() {
                                      isEditBloodType = false;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _heightController
                                  ..text = state.patient.height.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Height',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _weightController
                                  ..text = state.patient.weight.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _eyesightController
                                  ..text = state.patient.eyesight.toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Eyesight',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _eyesightController
                                  ..text = state.patient.medicalNote,
                                maxLines: 2,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Allergic things',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
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
              ],
            );
          }
          return Text('');
        }),
      ),
    );
  }

  _showEditAlert(BuildContext buildContext) {
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return editImage();
        });
  }

  Widget editImage() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {},
            child: Text('Edit'),
          ),
        ],
      ),
    );
  }
}
