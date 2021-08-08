import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:personhealth/blocs/home_blocs.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/events/home_events.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/screens/haudq/home.dart';
import 'package:personhealth/states/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  late bool isLogin = false;

  @override
  void initState() {
    _loginBloc = BlocProvider.of(context);
    super.initState();
  } //end initialize

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.cyan.shade500,
          Colors.cyan.shade300,
          Colors.cyan.shade400
        ])),
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: TextField(
                            controller: _userController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Your phone",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200))),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        print(state);
                        if (state is LoginStateFailure) {
                          return _displayTopMotionToast(context, "fail");
                        }
                        if (state is LoginEmptyState) {
                          return _displayTopMotionToast(context, "empty");
                        }
                        if (state is LoginStateSuccess) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(create: (context) => HomeBloc()..add(HomeFetchEvent()), child: HomeScreen(),)));
                        }
                      },
                      child: InkWell(
                        onTap: () async {
                          _loginBloc.add(LoginEvent(
                              username: _userController.value.text,
                              password: _passwordController.value.text));
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              color: Colors.cyan.shade500,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Create new account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  _displayTopMotionToast(BuildContext context, String msg) {
    switch (msg) {
      case "fail":
        MotionToast.error(
          title: "ERROR",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Username and password is invalid",
          animationType: ANIMATION.FROM_BOTTOM,
          position: MOTION_TOAST_POSITION.BOTTOM,
          width: 300,
        ).show(context);
        break;
      case "empty":
        MotionToast.warning(
          title: "WARNING",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          description: "Username and password is not blank",
          animationType: ANIMATION.FROM_BOTTOM,
          position: MOTION_TOAST_POSITION.BOTTOM,
          width: 300,
        ).show(context);
        break;
    }
  }
}
