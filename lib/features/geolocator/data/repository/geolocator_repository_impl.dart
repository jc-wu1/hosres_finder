import 'package:geolocator/geolocator.dart';
import 'package:hosres_finder/features/geolocator/domain/repository/geolocator_repository.dart';

class GeolocatorRepositoryImpl implements GeolocatorRepository {
  GeolocatorRepositoryImpl();

  @override
  Future<Position?> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
