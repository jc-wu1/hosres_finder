import 'package:hosres_finder/features/fav_places/domain/repository/fav_places_repository.dart';

import '../../../places/data/model/place_nearby_model.dart';

class SaveFavPlaceUsecase {
  final FavPlacesRepository repository;

  SaveFavPlaceUsecase(this.repository);

  Future<void> call(
    Result params,
  ) async {
    return await repository.saveFavPlace(params);
  }
}
