import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/home_events.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/models/examination.dart';
import 'package:personhealth/repositorys/clinic_repository.dart';
import 'package:personhealth/repositorys/examination_repository.dart';
import 'package:personhealth/repositorys/local_data.dart';
import 'package:personhealth/states/home_states.dart';

class HomeBloc extends Bloc<HomeBloc, HomeState> {
  HomeBloc():super(HomeStateInitial());

  @override
  Stream<HomeState> mapEventToState(HomeBloc event) async* {
    if (event is HomeFetchEvent) {
      //Get name, get image, get clinics near you, get examination today
      String? name = await LocalData().getName();
      String? image = await LocalData().getImage();
      int? patientId = await LocalData().getPatientId();

      //get address to compare with clinic.
      String? district = "1"; //require when login success
      List<Clinic> clinics = await getClinicsByDistrict(district);

      Examination? examination = await getExaminationLast();
      if (examination != null) {
        yield HomeStateSuccess(name: name!, image: image!, clinics: clinics, examination: examination);
      } else {
        examination = new Examination(0, "date", "diagnose", 0, "clinicName", 0, "advise", "rateStatus");
        yield HomeStateSuccess(name: name!, image: image!, clinics: clinics, examination: examination);
      }

    }
    if (event is HomeChangeDistrictEvent) {
      try {
        String? name = await LocalData().getName();
        String? image = await LocalData().getImage();
        String district = event.district;
        List<Clinic> clinics = await getClinicsByDistrict(district);
        Examination? examination = await getExaminationLast();
        if (examination != null) {
          yield HomeStateSuccess(name: name!, image: image!, clinics: clinics, examination: examination);
        } else {
          examination = new Examination(0, "date", "diagnose", 0, "clinicName", 0, "advise", "rateStatus");
          yield HomeStateSuccess(name: name!, image: image!, clinics: clinics, examination: examination);
        }
      } catch (exception) {
        print('State error: ' + exception.toString());
        var currentState = state as HomeStateSuccess;
        yield currentState;
      }
    }
  }
}