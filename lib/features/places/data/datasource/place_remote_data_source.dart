// https://maps.googleapis.com/maps/api/place/nearbysearch/json
//   ?keyword=cruise
//   &location=-33.8670522%2C151.1957362
//   &radius=1500
//   &type=restaurant
//   &key=YOUR_API_KEY

import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';
import 'package:hosres_finder/features/places/data/model/search_place_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'place_remote_data_source.g.dart';

@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/place/")
abstract class PlaceRemoteDataSource {
  factory PlaceRemoteDataSource(
    Dio dio, {
    String baseUrl,
  }) = _PlaceRemoteDataSource;

  @GET("nearbysearch/json")
  Future<PlaceNearbyModel> fetchPlaceNearby(
    @Query('location') String latlong,
    @Query('radius') double radius,
    @Query('type') String type,
    @Query('key') String apiKey,
  );

  @GET("findplacefromtext/json")
  Future<SearchPlacesModel> searchPlaceByKeyword(
    @Query('fields') String fields,
    @Query('input') String keyword,
    @Query('inputtype') String type,
    @Query('key') String apiKey,
  );
}
