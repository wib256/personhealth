import 'package:formz/formz.dart';

enum NameValidationError{invalid}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([String value = '']):super.pure(value);
  const Name.dirty([String value = '']):super.dirty(value);

  @override
  NameValidationError? validator(String? value) {
    if (value!.trim().compareTo('') == 0) {
      return null;
    } else {
      return NameValidationError.invalid;
    }
  }
}