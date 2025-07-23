import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/profile/domain/usecases/get_my_favorite_use_case.dart';
import 'package:shartflix/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:shartflix/features/profile/domain/usecases/upload_profile_use_case.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_event.dart';
import 'package:shartflix/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetMyFavoriteUseCase _getMyFavoriteUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final UploadProfilePhotoUseCase _uploadProfileUseCase;

  ProfileBloc(
    this._getMyFavoriteUseCase,
    this._getProfileUseCase,
    this._uploadProfileUseCase,
  ) : super(ProfileInitialState()) {
    on<ProfileLoadedEvent>(_onLoadProfile);
    on<MyFavoritesLoadedEvent>(_onLoadFavorites);
    on<PhotoUploadEvent>(_onPhotoUpload);
  }

  Future<void> _onLoadProfile(
    ProfileLoadedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await _getProfileUseCase();
    result.fold(
      (error) => emit(ProfileErrorState(error.message)),
      (profile) => emit(ProfileLoadedState(model: profile)),
    );
  }

  Future<void> _onLoadFavorites(
    MyFavoritesLoadedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());
    final result = await _getMyFavoriteUseCase();
    result.fold(
      (error) => emit(ProfileErrorState(error.message)),
      (movies) => emit(MyFavoritesCompleteState(favoriteMovies: movies)),
    );
  }

  Future<void> _onPhotoUpload(PhotoUploadEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUploadLoadingState());
    final result = await _uploadProfileUseCase(event.file);
    result.fold(
      (error) => emit(ProfileErrorState(error.message)),
      (user) => emit(PhotoUploadCompleteState(user: user)),
    );
  }
}
