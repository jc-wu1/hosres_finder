part of 'place_nearby_bloc.dart';

enum Status {
  initial,
  loading,
  complete,
  failure,
}

class PlaceNearbyState extends Equatable {
  const PlaceNearbyState({
    this.hospitalStatus = Status.initial,
    this.restaurantStatus = Status.initial,
    this.hospitals = const <Result>[],
    this.restaurants = const <Result>[],
    this.favPlaces = const <Result>[],
  });

  final Status hospitalStatus;
  final Status restaurantStatus;
  final List<Result> hospitals;
  final List<Result> restaurants;
  final List<Result> favPlaces;

  PlaceNearbyState copyWith({
    Status? hospitalStatus,
    Status? restaurantStatus,
    List<Result>? hospitals,
    List<Result>? restaurants,
    List<Result>? favPlaces,
  }) {
    return PlaceNearbyState(
      hospitalStatus: hospitalStatus ?? this.hospitalStatus,
      restaurantStatus: restaurantStatus ?? this.restaurantStatus,
      hospitals: hospitals ?? this.hospitals,
      restaurants: restaurants ?? this.restaurants,
      favPlaces: favPlaces ?? this.favPlaces,
    );
  }

  @override
  List<Object> get props => [
        hospitalStatus,
        restaurantStatus,
        hospitals,
        restaurants,
        favPlaces,
      ];
}
