import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio getDio() {
  Dio dio = Dio();
  dio
    ..options.connectTimeout = const Duration(seconds: 20)
    ..options.receiveTimeout = const Duration(seconds: 20);
  dio.interceptors.add(
    PrettyDioLogger(),
  );
  return dio;
}
