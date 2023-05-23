import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/network/network_info.dart';
import 'package:hosres_finder/features/places/data/datasource/place_remote_data_source.dart';

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
    String keyword,
    String type,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.fetchPlaceNearby(
          '$lat,$long',
          keyword,
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
              '',
            ),
          );
        }
      } catch (e) {
        return Left(
          ServerFailure(
            'error',
            e.toString(),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
