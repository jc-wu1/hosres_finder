part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchRequested extends SearchEvent {
  final String keyword;

  const SearchRequested(this.keyword);

  @override
  List<Object> get props => [keyword];
}
