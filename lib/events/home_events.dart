import 'package:personhealth/blocs/home_blocs.dart';

class HomeFetchEvent extends HomeBloc{}

class HomeChangeDistrictEvent extends HomeBloc{
  final String district;
  HomeChangeDistrictEvent({required this.district});
}