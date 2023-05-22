import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/places/domain/usecase/get_place_nearby_usecase.dart';

import '../data/model/place_model.dart';

part 'place_nearby_event.dart';
part 'place_nearby_state.dart';

class PlaceNearbyBloc extends Bloc<PlaceNearbyEvent, PlaceNearbyState> {
  PlaceNearbyBloc(this.getPlaceNearby) : super(const PlaceNearbyState()) {
    on<PlaceNearbyRequested>(_onPlaceNearbyRequested);
  }

  final GetPlaceNearbyUsecase getPlaceNearby;

  Future<void> _onPlaceNearbyRequested(
    PlaceNearbyRequested event,
    Emitter<PlaceNearbyState> emit,
  ) async {
    emit(
      state.copyWith(
        hospitalStatus: Status.loading,
      ),
    );
    try {
      final result = await getPlaceNearby(event.params);

      result.fold(
        (l) => emit(
          state.copyWith(
            hospitalStatus: Status.failure,
          ),
        ),
        (r) => emit(
          state.copyWith(
            hospitalStatus: Status.complete,
            hospitals: r.result,
          ),
        ),
      );
    } catch (e) {
      return emit(
        state.copyWith(
          hospitalStatus: Status.failure,
        ),
      );
    }
  }
}
