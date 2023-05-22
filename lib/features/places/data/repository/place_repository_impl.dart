import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/network/network_info.dart';
import 'package:hosres_finder/features/places/data/datasource/place_remote_data_source.dart';
import 'package:hosres_finder/features/places/data/model/search_place_model.dart';

import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';

import '../../../../core/constant.dart';
import '../../domain/repository/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  final NetworkInfo networkInfo;
  final PlaceRemoteDataSource remoteDataSource;

  PlaceRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, PlaceNearbyModel>> getPlaceNearby(
    double lat,
    double long,
    String type,
  ) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.fetchPlaceNearby(
        '$lat,$long',
        radiusDefault,
        type,
        apiKey,
      );
      if (response.status == "OK") {
        return Right(response);
      } else {
        return Left(
          ServerFailure(
            response.status!,
            response.errorMessage!,
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, SearchPlacesModel>> searchPlaceByKeyword(
    String keyword,
  ) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.searchPlaceByKeyword(
        fields,
        keyword,
        'textquery',
        apiKey,
      );
      if (response.status == "OK") {
        return Right(response);
      } else {
        return Left(
          ServerFailure(
            response.status!,
            response.errorMessage!,
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
