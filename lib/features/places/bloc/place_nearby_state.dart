part of 'place_nearby__bloc.dart';

enum Status {
  initial,
  loading,
  complete,
  failure,
}

class PlaceNearbyState extends Equatable {
  final Status hospitalStatus;
  final List<PlaceModel> hospitals;

  const PlaceNearbyState({
    this.hospitalStatus = Status.initial,
    this.hospitals = const <PlaceModel>[],
  });

  PlaceNearbyState copyWith({
    Status? hospitalStatus,
    List<PlaceModel>? hospitals,
  }) {
    return PlaceNearbyState(
      hospitalStatus: hospitalStatus ?? this.hospitalStatus,
      hospitals: hospitals ?? this.hospitals,
    );
  }

  @override
  List<Object?> get props => [
        hospitalStatus,
        hospitals,
      ];
}
