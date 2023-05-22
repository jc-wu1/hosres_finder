part of 'geolocator_bloc.dart';

enum GeolocatorStatus {
  initial,
  loading,
  complete,
  failure,
}

class GeolocatorState extends Equatable {
  final GeolocatorStatus status;
  final Set<Marker> markers;
  final Position? position;

  const GeolocatorState({
    this.status = GeolocatorStatus.initial,
    this.markers = const <Marker>{},
    this.position,
  });

  GeolocatorState copyWith({
    GeolocatorStatus? status,
    Set<Marker>? markers,
    Position? position,
  }) {
    return GeolocatorState(
      status: status ?? this.status,
      markers: markers ?? this.markers,
      position: position ?? this.position,
    );
  }

  @override
  List<Object?> get props => [
        status,
        markers,
        position,
      ];
}
