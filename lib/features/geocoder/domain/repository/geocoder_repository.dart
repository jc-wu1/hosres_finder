import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/error/failures.dart';
import 'package:hosres_finder/features/geocoder/data/model/geocoder_model.dart';

abstract class GeocoderRepository {
  Future<Either<Failure, GeocoderModel>> getLocationName(String latlng);
}
