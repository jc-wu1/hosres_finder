import 'package:equatable/equatable.dart';
import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/usecase/usecase.dart';
import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';
import 'package:hosres_finder/features/places/domain/repository/place_repository.dart';

class GetPlaceNearbyUsecase
    extends UseCase<PlaceNearbyModel, PlaceNearbyParams> {
  final PlaceRepository repository;

  GetPlaceNearbyUsecase(this.repository);

  @override
  Future<Either<Failure, PlaceNearbyModel>> call(
    PlaceNearbyParams params,
  ) async {
    return await repository.getPlaceNearby(
      params.lat,
      params.long,
      params.type,
    );
  }
}

class PlaceNearbyParams extends Equatable {
  final double lat;
  final double long;
  final String type;

  const PlaceNearbyParams(this.lat, this.long, this.type);

  @override
  List<Object?> get props => [
        lat,
        long,
        type,
      ];
}
