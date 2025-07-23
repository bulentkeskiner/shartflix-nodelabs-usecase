import 'package:equatable/equatable.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object?> get props => [];
}

class DiscoverInitialLoad extends DiscoverEvent {}

class DiscoverLoadMore extends DiscoverEvent {}

class DiscoverToggleFavorite extends DiscoverEvent {
  final String itemId;

  const DiscoverToggleFavorite(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class DiscoverRefreshEvent extends DiscoverEvent {}
