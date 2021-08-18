
class RegisterState {
  final String? phone;
  final String? password;
  final String? confirm;
  final String? name;
  final String? dob;
  final String? gender;
  final String? address;
  final bool? status;
  const RegisterState({required this.phone, required this.password, required this.confirm, required this.name, required this.dob, required this.gender, required this.address, required this.status});
}

class RegisterStateInitial extends RegisterState {
  RegisterStateInitial() : super(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
}
class RegisterStateFailure extends RegisterState {
  final String? phone;
  final String? password;
  final String? confirm;
  final String? name;
  final String? dob;
  final String? gender;
  final String? address;
  final bool? status;
  const RegisterStateFailure({required this.phone, required this.password, required this.confirm, required this.name, required this.dob, required this.gender, required this.address, required this.status}) : super(phone: phone, password: password, confirm: confirm, name: name, dob: dob, gender: gender, address: address, status: status);
}
class RegisterStateSuccess extends RegisterState {
  RegisterStateSuccess() : super(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: true);
}