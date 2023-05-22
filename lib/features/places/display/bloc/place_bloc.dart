import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/places/data/model/place_nearby_model.dart';
import 'package:hosres_finder/features/places/domain/usecase/get_place_nearby_usecase.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc(this.getPlaceNearby) : super(PlaceInitial()) {
    on<PlaceNearbyRequested>(_onPlaceNearbyRequested);
  }

  final GetPlaceNearbyUsecase getPlaceNearby;

  Future<void> _onPlaceNearbyRequested(
    PlaceNearbyRequested event,
    Emitter<PlaceState> emit,
  ) async {
    emit(PlaceLoadInProgress());
    try {
      final result = await getPlaceNearby(event.params);
      result.fold(
        (l) => emit(const PlaceLoadFailure()),
        (r) => emit(PlaceLoadComplete(r)),
      );
    } catch (e) {
      return emit(const PlaceLoadFailure());
    }
  }
}
