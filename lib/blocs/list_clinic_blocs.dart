import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/list_clinic_events.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/repositorys/clinic_repository.dart';
import 'package:personhealth/states/list_clinic_states.dart';

class ListClinicBloc extends Bloc<ListClinicBloc, ListClinicState> {
  ListClinicBloc():super(ListClinicStateInitial());

  @override
  Stream<ListClinicState> mapEventToState(ListClinicBloc event) async* {
    if (event is ListClinicFetchEvent) {
      List<Clinic> clinics = await getClinicsFromApi();
      if (clinics.isNotEmpty || clinics.length > 0) {
        yield ListClinicStateSuccess(clinics: clinics);
      } else {
        List<Clinic> clinicsEmpty = [];
        yield ListClinicStateSuccess(clinics: clinicsEmpty);
      }
    }
    if (event is ListClinicSearchEvent) {
      List<Clinic> clinics = await getClinicsFromApi();
      List<Clinic> result = [];
      if (clinics.isNotEmpty || clinics.length > 0) {
        for (int i = 0; i < clinics.length; i++) {
          if (clinics[i].address.toUpperCase().contains(event.searchClinic.toUpperCase())) {
            result.add(clinics[i]);
          }
        }
        yield ListClinicStateSuccess(clinics: result);
      } else {
        List<Clinic> clinicsEmpty = [];
        yield ListClinicStateSuccess(clinics: clinicsEmpty);
      }
    }
  }
}