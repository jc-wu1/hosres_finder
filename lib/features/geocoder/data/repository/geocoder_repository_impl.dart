import 'package:hosres_finder/core/constant.dart';
import 'package:hosres_finder/features/geocoder/data/datasource/geocoder_remote_data_source.dart';
import 'package:hosres_finder/features/geocoder/data/model/geocoder_model.dart';
import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/features/geocoder/domain/repository/geocoder_repository.dart';

import '../../../../core/network/network_info.dart';

class GeocoderRepositoryImpl implements GeocoderRepository {
  final NetworkInfo networkInfo;
  final GeocoderRemoteDataSource remoteDataSource;

  GeocoderRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, GeocoderModel>> getLocationName(
    String latlng,
  ) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.fetchLocationName(latlng, apiKey);
      if (response.status == "OK") {
        return Right(response);
      } else {
        return Left(
          ServerFailure(
            response.status!,
            response.errorMsg!,
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
