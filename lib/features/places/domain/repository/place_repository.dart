import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/error/failures.dart';
import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';
import 'package:hosres_finder/features/places/data/model/search_place_model.dart';

abstract class PlaceRepository {
  Future<Either<Failure, PlaceNearbyModel>> getPlaceNearby(
    double lat,
    double long,
    String type,
  );

  Future<Either<Failure, SearchPlacesModel>> searchPlaceByKeyword(
    String keyword,
  );
}
