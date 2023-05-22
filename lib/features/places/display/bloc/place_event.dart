part of 'place_bloc.dart';

abstract class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class PlaceNearbyRequested extends PlaceEvent {
  final PlaceNearbyParams params;

  const PlaceNearbyRequested(this.params);

  @override
  List<Object> get props => [params];
}
