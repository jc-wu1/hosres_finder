part of 'place_nearby_bloc.dart';

abstract class PlaceNearbyEvent extends Equatable {
  const PlaceNearbyEvent();

  @override
  List<Object> get props => [];
}

class PlaceNearbyRequested extends PlaceNearbyEvent {
  final PlaceNearbyParams params;

  const PlaceNearbyRequested(this.params);

  @override
  List<Object> get props => [params];
}
