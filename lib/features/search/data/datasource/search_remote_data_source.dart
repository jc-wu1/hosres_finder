import 'package:hosres_finder/features/search/data/model/search_place_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'search_remote_data_source.g.dart';

@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/place/")
abstract class SearchRemoteDataSource {
  factory SearchRemoteDataSource(
    Dio dio, {
    String baseUrl,
  }) = _SearchRemoteDataSource;

  @GET("findplacefromtext/json")
  Future<SearchPlacesModel> searchPlaceByKeyword(
    @Query('fields') String fields,
    @Query('input') String keyword,
    @Query('inputtype') String type,
    @Query('key') String apiKey,
  );
}
