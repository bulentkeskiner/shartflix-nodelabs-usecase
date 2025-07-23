import 'package:equatable/equatable.dart';
import 'package:shartflix/models/movie_model.dart';
import 'package:shartflix/models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileUploadLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserModel model;

  const ProfileLoadedState({required this.model});

  @override
  List<Object?> get props => [model];
}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class MyFavoritesCompleteState extends ProfileState {
  final List<MovieModel> favoriteMovies;

  const MyFavoritesCompleteState({required this.favoriteMovies});

  @override
  List<Object?> get props => [favoriteMovies];
}

class PhotoUploadCompleteState extends ProfileState {
  final UserModel user;

  const PhotoUploadCompleteState({required this.user});

  @override
  List<Object?> get props => [user];
}
