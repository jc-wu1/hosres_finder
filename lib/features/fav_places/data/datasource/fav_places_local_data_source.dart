import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../places/data/model/place_nearby_model.dart';

abstract class FavPlacesLocalDataSource {
  Future<List<Result>?> fetchFavPlaces();

  Future<void> saveFavPlaces(Result placeToSave);

  Future<void> deleteFavPlaces(Result placeToSave);
}

const favPlaceKey = 'FAV_PLACES';

class FavPlacesLocalDataSourceImpl implements FavPlacesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavPlacesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Result>?> fetchFavPlaces() {
    final jsonString = sharedPreferences.getString(favPlaceKey);
    if (jsonString != null) {
      final List<Result> x = List<Result>.from(
        json.decode(jsonString).map(
              (x) => Result.fromJson(x),
            ),
      );
      return Future.value(x);
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<void> saveFavPlaces(Result placeToSave) async {
    List<Result> places = await fetchFavPlaces() ?? <Result>[];

    places.add(placeToSave);

    sharedPreferences.setString(favPlaceKey, places.toString());
  }

  @override
  Future<void> deleteFavPlaces(Result placeToSave) async {
    List<Result> places = await fetchFavPlaces() ?? <Result>[];

    places.remove(placeToSave);

    sharedPreferences.setString(favPlaceKey, places.toString());
  }
}
