import 'package:hosres_finder/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:hosres_finder/core/usecase/usecase.dart';
import 'package:hosres_finder/features/places/data/model/search_place_model.dart';
import 'package:hosres_finder/features/places/domain/repository/place_repository.dart';

class SearchPlacesByKeywordUsecase extends UseCase<SearchPlacesModel, String> {
  final PlaceRepository repository;

  SearchPlacesByKeywordUsecase(this.repository);

  @override
  Future<Either<Failure, SearchPlacesModel>> call(
    String params,
  ) async {
    return await repository.searchPlaceByKeyword(params);
  }
}
