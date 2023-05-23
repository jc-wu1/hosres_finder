import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/usecase/usecase.dart';
import 'package:hosres_finder/features/fav_places/domain/repository/fav_places_repository.dart';

import '../../../places/data/model/place_nearby_model.dart';

class GetFavPlacesUsecase extends UseCase<List<Result>?, NoParams> {
  final FavPlacesRepository repository;

  GetFavPlacesUsecase(this.repository);

  @override
  Future<Either<Failure, List<Result>?>> call(
    NoParams params,
  ) async {
    return await repository.getFavPlaces();
  }
}
