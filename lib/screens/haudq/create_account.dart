import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/blocs/register_blocs.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/events/register_events.dart';
import 'package:personhealth/screens/login_screen.dart';
import 'package:personhealth/states/register_states.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late RegisterBloc _registerBloc;
  String dropdownValue = 'Male';
  String phone = '';
  String password = '';
  String confirm = '';
  String name = '';
  String dob = DateTime.now().toString();
  String gender = '';
  String address = '';

  @override
  void initState() {
    _registerBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green[300],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/white.png'),
                      height: 150,
                      width: 150,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Welcome to PHR system",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Create new Account",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitPhoneEvent(
                                            phone: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.phone,
                                      hintText: "Your phone",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitPasswordEvent(
                                            password: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.password,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child:  BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  obscureText: true,
                                  onChanged: (value) {
                                    confirm = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitConfirmEvent(
                                            password: password, confirm: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.confirm,
                                      hintText: "Confirm password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitNameEvent(
                                            name: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.name,
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: DateTimePicker(
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              dateLabelText: 'Date of birth',
                              onChanged: (val) => print(val),
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) {
                                val == null ? dob = DateTime.now().toString() : dob = val;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Gender  ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                DropdownButton(
                                  value: dropdownValue,
                                  icon: Icon(Icons.expand_more),
                                  iconSize: 20,
                                  elevation: 16,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>['Male', 'Female']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              bloc: _registerBloc,
                              builder: (context, state) {
                                return TextField(
                                  onChanged: (value) {
                                    address = value;
                                  },
                                  onSubmitted: (value) {
                                    _registerBloc.add(
                                        RegisterOnSubmitAddressEvent(
                                            address: value));
                                  },
                                  decoration: InputDecoration(
                                      errorText: state.address,
                                      hintText: "Address",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          listener: (context, state) {
            if (state is RegisterStateSuccess) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BlocProvider(create: (context) =>LoginBloc()..add(LoginFetchEvent()),child: LoginScreen(),)));
            }
            if (state is RegisterStateFailure) {
              if (!state.status!) {
                if (state.phone != null) {
                  _displayTopMotionToast(context, '0');
                }
              } else {
                _displayTopMotionToast(context, '1');
              }
            }
          },
          child: InkWell(
            onTap: () {
              _registerBloc.add(RegisterEvent(phone: phone, password: password, confirm: confirm, name: name, dob: dob, gender: dropdownValue, address: address));
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Create",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _displayTopMotionToast(BuildContext context, String msg) {
    switch (msg) {
      case "0":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Unable to connect to the system.",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
      case "1":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Phone number not available.",
          animationType: ANIMATION.FROM_TOP,
          position: MOTION_TOAST_POSITION.CENTER,
          width: 300,
        ).show(context);
        break;
    }
  }
}
