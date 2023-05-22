import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/usecase/usecase.dart';
import 'package:hosres_finder/features/geocoder/data/model/geocoder_model.dart';
import 'package:hosres_finder/features/geocoder/domain/repository/geocoder_repository.dart';

class GetLocationNameUsecase extends UseCase<GeocoderModel, String> {
  final GeocoderRepository repository;

  GetLocationNameUsecase(this.repository);

  @override
  Future<Either<Failure, GeocoderModel>> call(
    String params,
  ) async {
    return await repository.getLocationName(params);
  }
}
