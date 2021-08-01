import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personhealth/blocs/patient_blocs.dart';
import 'package:personhealth/states/patient_states.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({Key? key}) : super(key: key);

  @override
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  late PatientBloc _patientBloc;
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _eyesightController = TextEditingController();
  final _medicalNoteController = TextEditingController();

  late XFile? _image;
  final picker = ImagePicker();

  _imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _patientBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child:
            BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
          if (state is PatientStateInitial) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Container(
                    child: CircularProgressIndicator(),
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
                SizedBox(
                  height: 200,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Container(
                      child: GestureDetector(
                        onLongPress: () {
                          _showEditAlert(context);
                        },
                        child: Image.network(
                          '${state.patient.image}',
                          errorBuilder: (context, exception, stracktrace) {
                            return Image.network(
                                'https://static2.yan.vn/YanNews/2167221/202102/facebook-cap-nhat-avatar-doi-voi-tai-khoan-khong-su-dung-anh-dai-dien-e4abd14d.jpg');
                          },
                        ),
                      ),
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
                Divider(

                ),
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
                              TextField(
                                controller: _nameController
                                  ..text = state.patient.name,
                                decoration: InputDecoration(
                                  labelText: 'Name',
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
                                controller: _dobController
                                  ..text = state.patient.dob,
                                decoration: InputDecoration(
                                  labelText: 'Date of birth',
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
                                controller: _genderController
                                  ..text = state.patient.gender,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  hintText: '${state.patient.name}',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _phoneController
                                  ..text = state.patient.phone,
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: '${state.patient.name}',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _addressController
                                  ..text = state.patient.address,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  labelText: 'Address',
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
                                controller: _bloodTypeController
                                  ..text = state.patient.bloodType,
                                decoration: InputDecoration(
                                  labelText: 'Blood Type',
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
