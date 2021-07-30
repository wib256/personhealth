import 'package:personhealth/blocs/rate_blocs.dart';
import 'package:personhealth/models/rating.dart';

class RateFetchEvent extends RateBloc{}

class RateClinicEvent extends RateBloc {
  final Rating rating;

  RateClinicEvent({required this.rating});
}
