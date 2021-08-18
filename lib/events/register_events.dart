import 'package:personhealth/blocs/register_blocs.dart';

class RegisterEvent extends RegisterBloc{
  final String phone;
  final String password;
  final String confirm;
  final String name;
  final String dob;
  final String gender;
  final String address;
  RegisterEvent({required this.phone, required this.password, required this.confirm, required this.name, required this.dob, required this.gender, required this.address});
}

class RegisterOnSubmitPhoneEvent extends RegisterBloc{
  final String phone;
  RegisterOnSubmitPhoneEvent({required this.phone});
}

class RegisterOnSubmitPasswordEvent extends RegisterBloc{
  final String password;
  RegisterOnSubmitPasswordEvent({required this.password});
}

class RegisterOnSubmitConfirmEvent extends RegisterBloc{
  final String password;
  final String confirm;
  RegisterOnSubmitConfirmEvent({required this.password, required this.confirm});
}

class RegisterOnSubmitNameEvent extends RegisterBloc{
  final String name;
  RegisterOnSubmitNameEvent({required this.name});
}

class RegisterOnSubmitAddressEvent extends RegisterBloc{
  final String address;
  RegisterOnSubmitAddressEvent({required this.address});
}