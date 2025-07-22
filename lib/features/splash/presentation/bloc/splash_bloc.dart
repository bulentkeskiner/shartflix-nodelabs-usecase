import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/splash/domain/usecases/check_token_use_case.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_event.dart';
import 'package:shartflix/features/splash/presentation/bloc/splash_state.dart';
import 'package:shartflix/models/no_params.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CheckTokenUseCase _checkTokenUseCase;

  SplashBloc(this._checkTokenUseCase) : super(SplashInitial()) {
    on<CheckAuthSplashEvent>(_checkAuth);
  }

  Future<void> _checkAuth(CheckAuthSplashEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    await Future.delayed(const Duration(seconds: 2));
    final result = await _checkTokenUseCase(params: NoParams());

    if (result) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
