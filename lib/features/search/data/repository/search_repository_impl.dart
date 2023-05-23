import 'package:dartz/dartz.dart';
import 'package:hosres_finder/features/search/data/datasource/search_remote_data_source.dart';

import '../../../../core/constant.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../model/search_place_model.dart';
import '../../domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final NetworkInfo networkInfo;
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, SearchPlacesModel>> searchPlaceByKeyword(
    String keyword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
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
