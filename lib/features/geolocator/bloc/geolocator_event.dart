part of 'geolocator_bloc.dart';

abstract class GeolocatorEvent extends Equatable {
  const GeolocatorEvent();

  @override
  List<Object> get props => [];
}

class GeolocatorLoaded extends GeolocatorEvent {}

class GeolocatorUpdated extends GeolocatorEvent {
  final Position newPosition;

  const GeolocatorUpdated(this.newPosition);

  @override
  List<Object> get props => [newPosition];
}
