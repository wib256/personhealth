import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/register_events.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/states/register_states.dart';

class RegisterBloc extends Bloc<RegisterBloc, RegisterState> {
  RegisterBloc():super(RegisterStateInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterBloc event) async* {
    if (event is RegisterOnSubmitPhoneEvent) {
      try {
        if (event.phone.trim().isEmpty || event.phone.length != 10) {
          yield RegisterStateFailure(phone: 'Example: XXX-XXX-XXXX', password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        } else {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
    if (event is RegisterOnSubmitPasswordEvent) {
      try {
        if (event.password.isEmpty) {
          yield RegisterStateFailure(phone: null, password: 'Password is not blank', confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        } else {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
    if (event is RegisterOnSubmitConfirmEvent) {
      try {
        if (event.confirm.isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: 'Password is not blank', name: null, dob: null, gender: null, address: null, status: false);
        } else if (event.confirm.compareTo(event.password) != 0) {
          yield RegisterStateFailure(phone: null, password: null, confirm: 'Incorrect', name: null, dob: null, gender: null, address: null, status: false);
        } else {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
    if (event is RegisterOnSubmitNameEvent) {
      try {
        if (event.name.trim().isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: 'Name is not blank', dob: null, gender: null, address: null, status: false);
        } else {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
    if (event is RegisterOnSubmitAddressEvent) {
      try {
        if (event.address.trim().isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: 'Address is not blank', status: false);
        } else {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
    if (event is RegisterEvent) {
      try {
        if (event.phone.trim().isEmpty || event.phone.length != 10) {
          yield RegisterStateFailure(phone: 'Example: XXX-XXX-XXXX', password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        } else if (event.password.isEmpty) {
          yield RegisterStateFailure(phone: null, password: 'Password is not blank', confirm: null, name: null, dob: null, gender: null, address: null, status: false);
        } else if (event.confirm.isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: 'Password is not blank', name: null, dob: null, gender: null, address: null, status: false);
        } else if (event.confirm.compareTo(event.password) != 0) {
          yield RegisterStateFailure(phone: null, password: null, confirm: 'Incorrect', name: null, dob: null, gender: null, address: null, status: false);
        } else if (event.name.trim().isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: 'Name is not blank', dob: null, gender: null, address: null, status: false);
        } else if (event.address.trim().isEmpty) {
          yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: 'Address is not blank', status: false);
        } else {
          String register = await createPatient(event.phone, event.password, event.name, event.dob, event.gender, event.address);
          switch (register) {
            case '0': yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false); break;
            case 'true': yield RegisterStateSuccess(); break;
            case 'doubly': yield RegisterStateFailure(phone: 'Phone number not available.', password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: true); break;
          }
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        yield RegisterStateFailure(phone: null, password: null, confirm: null, name: null, dob: null, gender: null, address: null, status: false);
      }
    }
  }
}