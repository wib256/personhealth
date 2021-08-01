import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personhealth/events/clinic_events.dart';
import 'package:personhealth/models/clinic.dart';
import 'package:personhealth/repositorys/clinic_repository.dart';
import 'package:personhealth/states/clinic_states.dart';

class ClinicBloc extends Bloc<ClinicBloc, ClinicState> {

  ClinicBloc():super(ClinicStateInitial());

  @override
  Stream<ClinicState> mapEventToState(ClinicBloc event) async* {
    if (event is ClinicFetchEvent) {
      try {
        if (state is ClinicStateInitial) {
          final clinics = await getClinicsFromApi();
          yield ClinicStateSuccess(clinics: clinics);
        } else if (state is ClinicStateSuccess) {
          final currentState = state as ClinicStateSuccess;
          final clinics = await getClinicsFromApi();
          yield currentState.cloneWith(clinics: clinics);
        }
      } catch (exception) {
        yield ClinicStateFailure();
      }
    }
    if (event is ClinicSearchEvent) {
      try {
        String searchName = event.search;
        if (state is ClinicStateInitial) {
          final clinicsT = await getClinicsFromApi();
          List<Clinic> clinics = [];
          for (int i =0; i < clinicsT.length;i++) {
            if (clinicsT[i].district.contains(searchName)) {
              clinics.add(clinicsT[i]);
            }
          }
          yield ClinicStateSuccess(clinics: clinics);
        } else if (state is ClinicStateSuccess) {
          final clinicsT = await getClinicsFromApi();
          List<Clinic> clinics = [];
          for (int i =0; i < clinicsT.length;i++) {
            if (clinicsT[i].district.contains(searchName)) {
              clinics.add(clinicsT[i]);
            }
          }
          yield ClinicStateSuccess(clinics: clinics);
        }
      } catch (exception) {
        yield ClinicStateFailure();
      }
    }
  }
}