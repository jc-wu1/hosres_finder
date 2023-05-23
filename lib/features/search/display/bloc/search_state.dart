part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoadInProgress extends SearchState {}

class SearchLoadComplete extends SearchState {
  final SearchPlacesModel candidate;

  const SearchLoadComplete(this.candidate);

  @override
  List<Object> get props => [candidate];
}

class SearchLoadFailure extends SearchState {}
