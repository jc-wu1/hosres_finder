import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosres_finder/features/geolocator/domain/repository/geolocator_repository.dart';

part 'geolocator_event.dart';
part 'geolocator_state.dart';

class GeolocatorBloc extends Bloc<GeolocatorEvent, GeolocatorState> {
  final GeolocatorRepository _repository;
  StreamSubscription? geolocatorSubscription;
  GoogleMapController? controller;

  GeolocatorBloc({
    required GeolocatorRepository repository,
  })  : _repository = repository,
        super(const GeolocatorState()) {
    on<GeolocatorLoaded>(_onGeolocatorLoaded);
    on<GeolocatorUpdated>(_onGeolocatorUpdated);
  }

  Future<void> _onGeolocatorLoaded(
    GeolocatorLoaded event,
    Emitter<GeolocatorState> emit,
  ) async {
    geolocatorSubscription?.cancel();

    final Position? position = await _repository.getCurrentLocation();

    add(
      GeolocatorUpdated(position!),
    );
  }

  FutureOr<void> _onGeolocatorUpdated(
    GeolocatorUpdated event,
    Emitter<GeolocatorState> emit,
  ) {
    emit(
      state.copyWith(
        status: GeolocatorStatus.complete,
        position: event.newPosition,
      ),
    );
  }

  @override
  Future<void> close() {
    geolocatorSubscription?.cancel();
    return super.close();
  }
}
