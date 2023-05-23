import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosres_finder/features/search/data/model/search_place_model.dart';
import 'package:hosres_finder/features/search/domain/usecase/search_places_by_keyword_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchPlacesByKeyword) : super(SearchInitial()) {
    on<SearchRequested>(_onSearchRequested);
  }

  final SearchPlacesByKeywordUsecase searchPlacesByKeyword;

  FutureOr<void> _onSearchRequested(
    SearchRequested event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadInProgress());
    try {
      final result = await searchPlacesByKeyword(event.keyword);
      result.fold(
        (l) => emit(SearchLoadFailure()),
        (r) => emit(SearchLoadComplete(r)),
      );
    } catch (e) {
      return emit(SearchLoadFailure());
    }
  }
}
