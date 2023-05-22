import 'package:hosres_finder/features/geocoder/data/model/geocoder_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'geocoder_remote_data_source.g.dart';

@RestApi(baseUrl: "https://maps.googleapis.com/maps/api/")
abstract class GeocoderRemoteDataSource {
  factory GeocoderRemoteDataSource(
    Dio dio, {
    String baseUrl,
  }) = _GeocoderRemoteDataSource;

  @GET("geocode/json")
  Future<GeocoderModel> fetchLocationName(
    @Query('latlng') String latlong,
    @Query('key') String key,
  );
}
