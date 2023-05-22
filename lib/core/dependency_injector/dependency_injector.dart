import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hosres_finder/features/geocoder/data/datasource/geocoder_remote_data_source.dart';
import 'package:hosres_finder/features/geocoder/data/repository/geocoder_repository_impl.dart';
import 'package:hosres_finder/features/geocoder/domain/repository/geocoder_repository.dart';
import 'package:hosres_finder/features/geocoder/domain/usecase/get_location_name_usecase.dart';
import 'package:hosres_finder/features/geolocator/data/repository/geolocator_repository_impl.dart';
import 'package:hosres_finder/features/geolocator/domain/repository/geolocator_repository.dart';
import 'package:hosres_finder/features/places/data/repository/place_repository_impl.dart';
import 'package:hosres_finder/features/places/domain/repository/place_repository.dart';
import 'package:hosres_finder/features/places/domain/usecase/get_place_nearby_usecase.dart';
import 'package:hosres_finder/features/places/domain/usecase/search_places_by_keyword_usecase.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/places/data/datasource/place_remote_data_source.dart';
import '../network/dio_wrapper.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<Dio>(getDio());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());

  /// Data sources
  sl.registerLazySingleton<PlaceRemoteDataSource>(
    () => PlaceRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<GeocoderRemoteDataSource>(
    () => GeocoderRemoteDataSource(sl()),
  );

  /// Repository
  sl.registerLazySingleton<PlaceRepository>(
    () => PlaceRepositoryImpl(
      sl<NetworkInfo>(),
      sl<PlaceRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<GeolocatorRepository>(
    () => GeolocatorRepositoryImpl(),
  );
  sl.registerLazySingleton<GeocoderRepository>(
    () => GeocoderRepositoryImpl(sl(), sl()),
  );

  /// Use cases
  sl.registerLazySingleton(() => GetPlaceNearbyUsecase(sl()));
  sl.registerLazySingleton(() => SearchPlacesByKeywordUsecase(sl()));

  /// Use cases
  sl.registerLazySingleton(() => GetLocationNameUsecase(sl()));
}
