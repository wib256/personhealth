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
        length: 2,
        child:
            BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
          if (state is PatientStateInitial) {
            return Column(
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
                        Icons.info,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Icon(Icons.directions_car),
                      Icon(Icons.directions_transit),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is PatientStateFailure) {
            return Text('Fail');
          } else if (state is PatientStateSuccess) {
            return Column(
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
                  child: TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(
                        Icons.info,
                        color: Colors.black,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: _nameController..text = state.patient.name,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _dobController..text = state.patient.dob,
                                decoration: InputDecoration(
                                  labelText: 'Date of birth',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _genderController..text = state.patient.gender,
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _phoneController..text = state.patient.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: _addressController..text = state.patient.address,
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText: '${state.patient.name}',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print('aaaaa');
                                    },
                                    icon: Icon(Icons.edit, color: Colors.blue,),
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
                      Icon(Icons.directions_transit),
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
