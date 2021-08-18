import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPassword.pure([String value = '']) : super.pure(value);
  const ConfirmPassword.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex =
  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return _passwordRegex.hasMatch(value ?? '')
        ? null
        : ConfirmPasswordValidationError.invalid;
  }
}