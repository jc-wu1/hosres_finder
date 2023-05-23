import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/fav_places/domain/usecase/get_fav_places_usecase.dart';
import 'package:hosres_finder/features/fav_places/domain/usecase/save_fav_place_usecase.dart';
import 'package:hosres_finder/features/places/domain/usecase/get_place_nearby_usecase.dart';

import '../data/model/place_nearby_model.dart';

part 'place_nearby_event.dart';
part 'place_nearby_state.dart';

class PlaceNearbyBloc extends Bloc<PlaceNearbyEvent, PlaceNearbyState> {
  PlaceNearbyBloc(
    this.getPlaceNearby,
    this.saveFavPlace,
    this.getFavPlaces,
  ) : super(const PlaceNearbyState()) {
    on<PlaceNearbyRequested>(_onPlaceNearbyRequested);
  }

  final GetPlaceNearbyUsecase getPlaceNearby;
  final GetFavPlacesUsecase getFavPlaces;

  final SaveFavPlaceUsecase saveFavPlace;

  Future<void> _onPlaceNearbyRequested(
    PlaceNearbyRequested event,
    Emitter<PlaceNearbyState> emit,
  ) async {
    try {
      final result = await getPlaceNearby(event.params);

      if (event.params.type == "hospital") {
        emit(
          state.copyWith(
            hospitalStatus: Status.loading,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              hospitalStatus: Status.failure,
            ),
          ),
          (r) {
            return emit(
              state.copyWith(
                hospitalStatus: Status.complete,
                hospitals: r.results!
                    .where(
                      (element) =>
                          element.rating! > 0 && element.openingHours != null,
                    )
                    .toList(),
              ),
            );
          },
        );
      } else {
        emit(
          state.copyWith(
            restaurantStatus: Status.loading,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              restaurantStatus: Status.failure,
            ),
          ),
          (r) {
            return emit(
              state.copyWith(
                restaurantStatus: Status.complete,
                restaurants: r.results!
                    .where(
                      (element) =>
                          element.rating! > 0 && element.openingHours != null,
                    )
                    .toList(),
              ),
            );
          },
        );
      }
    } catch (e) {
      return emit(
        state.copyWith(
          hospitalStatus: Status.failure,
          restaurantStatus: Status.failure,
        ),
      );
    }
  }
}
