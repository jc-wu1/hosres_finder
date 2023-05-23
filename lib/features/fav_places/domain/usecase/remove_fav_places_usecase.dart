import 'package:hosres_finder/features/fav_places/domain/repository/fav_places_repository.dart';

import '../../../places/data/model/place_nearby_model.dart';

class RemoveFavPlaceUsecase {
  final FavPlacesRepository repository;

  RemoveFavPlaceUsecase(this.repository);

  Future<void> call(
    Result params,
  ) async {
    return await repository.removeFavPlace(params);
  }
}
