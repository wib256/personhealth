import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/login_repository.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/states/login_states.dart';

class LoginBloc extends Bloc<LoginBloc, LoginState> {
  LoginBloc():super(LoginStateInitial());

  @override
  Stream<LoginState> mapEventToState(LoginBloc event) async* {
    if (event is LoginFetchEvent) {
      yield LoginStateFailure(errorMessage: '');
    }
    if (event is LoginEvent) {
      try {
        if (state is LoginStateFailure) {
          bool isLogin = await login(event.username, event.password);
          if (isLogin) {
            String? phone = await LocalData().getPhone();
            String? token = await LocalData().getToken();
            final parts = token!.split('.');
            final payload = parts[1];
            final String decoded = utf8.decode(base64Url.decode(payload));
            if (phone != null && decoded.contains('PATIENT')) {
              Patient? patient = await getPatientByPhoneFromApi(phone);
              if (patient != null) {
                await LocalData().saveGender(patient.gender);
                await LocalData().savePatientId(patient.id);
                await LocalData().saveName(patient.name);
                await LocalData().setIsLogin();
                yield LoginStateSuccess();
              } else {
                yield LoginStateFailure(errorMessage: 'Incorrect phone or password');
              }
            }
          } else {
            yield LoginStateFailure(errorMessage: 'Incorrect phone or password');
          }
        }
      } catch (exception) {
        print(exception);
        yield LoginStateFailure(errorMessage: 'Incorrect phone or password');
      }
    }
  }
}