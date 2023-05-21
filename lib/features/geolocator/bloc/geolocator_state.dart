part of 'geolocator_bloc.dart';

abstract class GeolocatorState extends Equatable {
  const GeolocatorState();

  @override
  List<Object> get props => [];
}

class GeolocatorInitial extends GeolocatorState {}

class GeolocatorLoadInProgress extends GeolocatorState {}

class GeolocatorLoadComplete extends GeolocatorState {
  final Position position;

  const GeolocatorLoadComplete({required this.position});

  @override
  List<Object> get props => [position];
}

class GeolocatorLoadFailure extends GeolocatorState {}
