import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
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

  /// Use cases
  sl.registerLazySingleton(() => GetPlaceNearbyUsecase(sl()));
  sl.registerLazySingleton(() => SearchPlacesByKeywordUsecase(sl()));
}
