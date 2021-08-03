import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/blocs/login_blocs.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/screens/home_screen.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 10),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
                width: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _userController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  icon: Icon(
                    Icons.phone,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(
                    Icons.vpn_key,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              if (state is LoginStateFailure) {
                return Text('${state.errorMessage}');
              }
              if (state is LoginStateInitial) {
                return Text('Please enter phone and password');
              }
              if (state is LoginStateSuccess) {
                isLogin = true;
              }
              return Text('');
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
              child: RaisedButton(
                onPressed: () async {
                  _loginBloc.add(LoginEvent(
                      username: _userController.value.text,
                      password: _passwordController.value.text));
                  await Future.delayed(Duration(seconds: 2));
                  if (isLogin) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(index: 0)));
                  }
                },
                child: Text('Login'),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                'Forgot password',
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
