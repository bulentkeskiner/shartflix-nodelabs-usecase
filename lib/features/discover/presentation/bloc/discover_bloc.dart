import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/discover/domain/usecases/get_movie_list_use_case.dart';
import 'package:shartflix/features/discover/domain/usecases/toggle_favorite_use_case.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_event.dart';
import 'package:shartflix/features/discover/presentation/bloc/discover_state.dart';
import 'package:shartflix/models/movie_model.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetMovieListUseCase _getMovieListUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  int currentPage = 1;
  bool _hasReachedMax = false;
  List<MovieModel> _items = [];

  DiscoverBloc(this._getMovieListUseCase, this._toggleFavoriteUseCase)
    : super(DiscoverInitialState()) {
    on<DiscoverInitialLoad>(_onMovieList);
    on<DiscoverRefreshEvent>(_onRefresh);
    on<DiscoverLoadMore>(_onMovieLoadMoreList);
    on<DiscoverToggleFavorite>(_onToggleFavorite);
  }

  _onRefresh(DiscoverRefreshEvent event, Emitter<DiscoverState> emit) {
    currentPage = 1;
    _hasReachedMax = false;
    _items = [];

    emit(DiscoverRefreshState());
    add(DiscoverInitialLoad());
  }

  _onMovieList(DiscoverEvent event, Emitter<DiscoverState> emit) async {
    currentPage = 1;
    _items = [];

    emit(DiscoverLoadingState());

    final result = await _getMovieListUseCase(params: currentPage);

    result.fold(
      (failure) {
        emit(DiscoverErrorState(failure.message));
      },
      (movie) {
        _items = movie.movies ?? [];

        var maxPage = movie.pagination?.maxPage ?? 0;
        var page = movie.pagination?.currentPage ?? 0;

        _hasReachedMax = page >= maxPage;
        if (!_hasReachedMax) currentPage = page + 1;

        emit(DiscoverLoadedState(items: _items, hasReachedMax: _hasReachedMax));
      },
    );
  }

  _onMovieLoadMoreList(DiscoverEvent event, Emitter<DiscoverState> emit) async {
    if (_hasReachedMax) return;

    if (emit is DiscoverLoadingState) return;

    emit(DiscoverLoadingState());

    final result = await _getMovieListUseCase(params: currentPage);

    result.fold(
      (failure) {
        emit(DiscoverErrorState(failure.message));
      },
      (movie) {
        _items.addAll(movie.movies ?? []);

        var maxPage = movie.pagination?.maxPage ?? 0;
        var page = (movie.pagination?.currentPage ?? 0);

        _hasReachedMax = page >= maxPage;
        if (!_hasReachedMax) currentPage = page + 1;

        emit(DiscoverLoadedState(items: _items, hasReachedMax: _hasReachedMax));
      },
    );
  }

  _onToggleFavorite(DiscoverToggleFavorite event, Emitter<DiscoverState> emit) async {
    emit(DiscoverLoadingFavoriteState());

    final result = await _toggleFavoriteUseCase(params: event.itemId);

    result.fold(
      (failure) {
        emit(DiscoverErrorState(failure.message));
      },
      (response) {
        final updatedList = _items.map((item) {
          return item.id == response.movie?.id ? response.movie! : item;
        }).toList();

        _items = updatedList;

        emit(DiscoverCompleteFavoriteState(action: response.action ?? "", items: _items));
      },
    );
  }
}
