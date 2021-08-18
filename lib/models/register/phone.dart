import 'package:formz/formz.dart';

enum PhoneValidationError{invalid}

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure([String value = '']):super.pure(value);
  const Phone.dirty([String value = '']):super.dirty(value);

  @override
  PhoneValidationError? validator(String? value) {
    if (value!.trim().compareTo('') == 0 && value.trim().length == 10) {
      return null;
    } else {
      return PhoneValidationError.invalid;
    }
  }
}