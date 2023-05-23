// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _PlaceRemoteDataSource implements PlaceRemoteDataSource {
  _PlaceRemoteDataSource(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://maps.googleapis.com/maps/api/place/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PlaceNearbyModel> fetchPlaceNearby(
    String latlong,
    String keyword,
    double radius,
    String type,
    String apiKey, {
    String lang = 'id',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'location': latlong,
      r'keyword': keyword,
      r'radius': radius,
      r'type': type,
      r'key': apiKey,
      r'language': lang,
    };
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<PlaceNearbyModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'nearbysearch/json',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PlaceNearbyModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
