part of 'fav_places_bloc.dart';

// abstract class FavPlacesState extends Equatable {
//   const FavPlacesState();

//   @override
//   List<Object> get props => [];
// }

// class FavPlacesInitial extends FavPlacesState {}

// class FavPlacesLoadInProgress extends FavPlacesState {}

// class FavPlacesLoadComplete extends FavPlacesState {
//   final List<Result> favPlaces;

//   const FavPlacesLoadComplete(this.favPlaces);

//   @override
//   List<Object> get props => [favPlaces];
// }

// class FavPlacesLoadFailure extends FavPlacesState {}

// class FavPlacesState extends Equatable {
//   final Status status;
//   final List<Result> favPlaces;

//   FavPlacesState(this.status, this.favPlaces);
// }

class FavPlacesState extends Equatable {
  const FavPlacesState({
    this.status = Status.initial,
    this.favPlaces = const <Result>[],
  });

  final Status status;
  final List<Result> favPlaces;

  FavPlacesState copyWith({
    Status? status,
    List<Result>? favPlaces,
  }) {
    return FavPlacesState(
      status: status ?? this.status,
      favPlaces: favPlaces ?? this.favPlaces,
    );
  }

  @override
  List<Object> get props => [
        status,
        favPlaces,
      ];
}
