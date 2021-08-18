import 'package:formz/formz.dart';
import 'package:personhealth/models/register/register_model.dart';

class RegisterState {
  final Phone phone;
  final Password password;
  final ConfirmPassword confirm;
  final Name name;
  final String dob, gender, address;
  final FormzStatus status;

  const RegisterState({
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.confirm = const ConfirmPassword.pure(),
    this.name = const Name.pure(),
    this.dob = '',
    this.gender = '',
    this.address = '',
    this.status = FormzStatus.pure,
  });

  RegisterState copyWith({
    Phone? phone,
    Password? password,
    ConfirmPassword? confirm,
    Name? name,
    String? dob,
    String? gender,
    String? address,
    FormzStatus? status,
  }) {
    return RegisterState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirm: confirm ?? this.confirm,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      status: status ?? this.status,
    );
  }
}