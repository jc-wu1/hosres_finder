part of 'fav_places_bloc.dart';

abstract class FavPlacesEvent extends Equatable {
  const FavPlacesEvent();

  @override
  List<Object> get props => [];
}

class FavPlacesSaved extends FavPlacesEvent {
  final Result placeToSave;

  const FavPlacesSaved(this.placeToSave);

  // @override
  // List<Object> get props => [placeToSave];
}

class FavPlacesRemoved extends FavPlacesEvent {
  final Result placeToRemove;

  const FavPlacesRemoved(this.placeToRemove);

  // @override
  // List<Object> get props => [placeToRemove];
}

class FavPlacesRequested extends FavPlacesEvent {}
