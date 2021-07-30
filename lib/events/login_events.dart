import 'package:personhealth/blocs/login_blocs.dart';

class LoginFetchEvent extends LoginBloc {}

class LoginEvent extends LoginBloc {
  final String username;
  final String password;
  LoginEvent({required this.username, required this.password});
}