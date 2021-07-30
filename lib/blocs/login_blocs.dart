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
      if (state is LoginStateFailure) {
        bool isLogin = await login(event.username, event.password);
        if (isLogin) {
          String? token = await LocalData().getToken();
          String? phone = await LocalData().getPhone();
          if (phone != null && token != null) {
            print(token + ',' + phone);
            Patient? patient = await getPatientByPhoneFromApi(phone);
            print(patient);
            if (patient != null) {
              await LocalData().saveGender(patient.gender);
              await LocalData().savePatientId(patient.id);
              await LocalData().saveName(patient.name);
              await LocalData().saveImage(patient.image);
              print(patient.gender+patient.id.toString()+patient.name+patient.image);
              yield LoginStateSuccess();
            }
          }

        } else {
          yield LoginStateFailure(errorMessage: 'Incorrect phone or password');
        }
      }
    }
  }
}