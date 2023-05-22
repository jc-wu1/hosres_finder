part of 'place_bloc.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceInitial extends PlaceState {}

class PlaceLoadInProgress extends PlaceState {}

class PlaceLoadComplete extends PlaceState {
  final PlaceNearbyModel places;

  const PlaceLoadComplete(this.places);

  @override
  List<Object> get props => [places];
}

class PlaceLoadFailure extends PlaceState {
  const PlaceLoadFailure();
}
