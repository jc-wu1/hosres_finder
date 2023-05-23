import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/core/usecase/usecase.dart';
import 'package:hosres_finder/features/fav_places/domain/usecase/get_fav_places_usecase.dart';
import 'package:hosres_finder/features/fav_places/domain/usecase/remove_fav_places_usecase.dart';
import 'package:hosres_finder/features/fav_places/domain/usecase/save_fav_place_usecase.dart';
import 'package:hosres_finder/features/places/bloc/place_nearby_bloc.dart';

import '../../../places/data/model/place_nearby_model.dart';

part 'fav_places_event.dart';
part 'fav_places_state.dart';

class FavPlacesBloc extends Bloc<FavPlacesEvent, FavPlacesState> {
  FavPlacesBloc(
    this.saveFavPlace,
    this.getFavPlaces,
    this.removeFavPlace,
  ) : super(const FavPlacesState()) {
    on<FavPlacesSaved>(_onFavPlacesSaved);
    on<FavPlacesRequested>(_onFavPlacesRequested);
    on<FavPlacesRemoved>(_onFavPlacesRemoved);
  }

  final SaveFavPlaceUsecase saveFavPlace;
  final GetFavPlacesUsecase getFavPlaces;
  final RemoveFavPlaceUsecase removeFavPlace;

  FutureOr<void> _onFavPlacesSaved(
    FavPlacesSaved event,
    Emitter<FavPlacesState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    saveFavPlace(event.placeToSave);
    emit(state.copyWith(status: Status.complete));
  }

  FutureOr<void> _onFavPlacesRequested(
    FavPlacesRequested event,
    Emitter<FavPlacesState> emit,
  ) async {
    // emit(FavPlacesLoadInProgress());
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );

    try {
      final result = await getFavPlaces(NoParams());
      result.fold(
        (l) {
          return emit(
            state.copyWith(
              status: Status.failure,
            ),
          );
          // return emit(FavPlacesLoadFailure());
        },
        (r) => emit(
          state.copyWith(
            status: Status.complete,
            favPlaces: r,
          ),
        ),
      );
    } catch (e) {
      return emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    }
  }

  FutureOr<void> _onFavPlacesRemoved(
    FavPlacesRemoved event,
    Emitter<FavPlacesState> emit,
  ) {
    emit(state.copyWith(status: Status.loading));
    removeFavPlace(event.placeToRemove);
    emit(state.copyWith(status: Status.complete));
  }
}
