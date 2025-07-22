import 'package:equatable/equatable.dart';
import 'package:shartflix/models/movie_model.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

class DiscoverInitialState extends DiscoverState {}

class DiscoverLoadingState extends DiscoverState {}

class DiscoverLoadingFavoriteState extends DiscoverState {}

class DiscoverCompleteFavoriteState extends DiscoverState {
  final String action;
  final List<MovieModel> items;

  const DiscoverCompleteFavoriteState({required this.action, required this.items});
}

class DiscoverLoadedState extends DiscoverState {
  final List<MovieModel> items;
  final bool hasReachedMax;

  const DiscoverLoadedState({required this.items, this.hasReachedMax = false});

  DiscoverLoadedState copyWith({List<MovieModel>? items, bool? hasReachedMax}) {
    return DiscoverLoadedState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [items, hasReachedMax];
}

/// Yükleme sırasında hata oldu
class DiscoverErrorState extends DiscoverState {
  final String message;

  const DiscoverErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
