import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/error/failures.dart';

import '../../../places/data/model/place_nearby_model.dart';

abstract class FavPlacesRepository {
  Future<Either<Failure, List<Result>?>> getFavPlaces();

  Future<void> saveFavPlace(Result placeToSave);

  Future<void> removeFavPlace(Result placeToSave);
}
