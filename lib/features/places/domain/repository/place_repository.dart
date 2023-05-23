import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/error/failures.dart';
import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';

abstract class PlaceRepository {
  Future<Either<Failure, PlaceNearbyModel>> getPlaceNearby(
    double lat,
    double long,
    String type,
    String keyword,
  );
}
