import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/login_events.dart';
import 'package:personhealth/models/patient.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/repositorys/login_repository.dart';
import 'package:personhealth/repositorys/patient_repository.dart';
import 'package:personhealth/states/login_states.dart';

class LoginBloc extends Bloc<LoginBloc, LoginState> {
  LoginBloc() : super(LoginStateInitial());


  @override
  Stream<LoginState> mapEventToState(LoginBloc event) async* {
    if (event is LoginFetchEvent) {
      yield LoginStateInitial();
    }
    if (event is LoginEvent) {
      if (event.username.trim().isEmpty || event.password.trim().isEmpty) {
        yield LoginEmptyState();
      } else {
        try {
          bool isLogin = await login(event.username, event.password);
          if (isLogin) {
            String? phone = await LocalData().getPhone();
            // String? token = await LocalData().getToken();
            // final parts = token!.split('.');
            // final payload = parts[1];
            final String decoded = 'PATIENT';
            //utf8.decode(base64Url.decode(payload));
            print(decoded);
            if (phone != null && decoded.contains('PATIENT')) {
              Patient? patient = await getPatientByPhoneFromApi(phone);
              if (patient != null) {
                await LocalData().saveGender(patient.gender);
                await LocalData().savePatientId(patient.id);
                await LocalData().saveName(patient.name);
                await LocalData().saveDob(patient.dob);
                await LocalData().saveImage(patient.image);
                await LocalData().setIsLogin();
                yield LoginStateSuccess(name: patient.name, image: patient.image);
              } else {
                yield LoginStateFailure(
                    errorMessage: 'Incorrect phone or password');
              }
            }
          } else {
            yield LoginStateFailure(
                errorMessage: 'Incorrect phone or password');
          }
        } catch (exception) {
          print(exception);
          yield LoginStateFailure(errorMessage: 'Incorrect phone or password');
        }
      }
    }
  }
}
