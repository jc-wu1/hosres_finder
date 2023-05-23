import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/features/fav_places/data/datasource/fav_places_local_data_source.dart';
import 'package:hosres_finder/features/fav_places/domain/repository/fav_places_repository.dart';
import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';

class FavPlacesRepositoryImpl implements FavPlacesRepository {
  final FavPlacesLocalDataSource localDataSource;

  FavPlacesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Result>?>> getFavPlaces() async {
    try {
      final response = await localDataSource.fetchFavPlaces();

      if (response != null) {
        return Right(response);
      } else {
        return Left(LocalStorageFailure());
      }
    } catch (e) {
      return Left(LocalStorageFailure());
    }
  }

  @override
  Future<void> saveFavPlace(Result placeToSave) {
    return localDataSource.saveFavPlaces(placeToSave);
  }

  @override
  Future<void> removeFavPlace(Result placeToSave) {
    return localDataSource.deleteFavPlaces(placeToSave);
  }
}
