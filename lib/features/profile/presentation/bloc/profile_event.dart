import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadedEvent extends ProfileEvent {
  const ProfileLoadedEvent();

  @override
  List<Object?> get props => [];
}

class MyFavoritesLoadedEvent extends ProfileEvent {
  const MyFavoritesLoadedEvent();

  @override
  List<Object?> get props => [];
}

class PhotoUploadEvent extends ProfileEvent {
  final File file;
  const PhotoUploadEvent(this.file);

  @override
  List<Object?> get props => [];
}
