import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/domain/entities/login_params.dart';
import 'package:shartflix/features/auth/domain/entities/register_params.dart';
import 'package:shartflix/features/auth/domain/use_cases/login_use_case.dart';
import 'package:shartflix/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:shartflix/features/auth/domain/use_cases/register_use_case.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_event.dart';
import 'package:shartflix/features/splash/domain/usecases/save_user_use_case.dart';

class AuthBloc extends Bloc<AuthEvent, DataState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final SaveUserUseCase _saveUserUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(
    this._registerUseCase,
    this._loginUseCase,
    this._saveUserUseCase,
    this._logoutUseCase,
  ) : super(DataInitial()) {
    on<RegisterSubmitted>(_onRegister);
    on<LoginSubmitted>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onRegister(RegisterSubmitted event, Emitter<DataState> emit) async {
    emit(DataLoading(uiEvent: UIEvent.registerPage));

    final result = await _registerUseCase(
      params: RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold((failure) {
      emit(DataFailed(error: failure.message, uiEvent: UIEvent.registerPage));
    }, (user) => emit(DataSuccess(data: user, uiEvent: UIEvent.registerPage)));
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<DataState> emit) async {
    emit(DataLoading(uiEvent: UIEvent.loginPage));

    final result = await _loginUseCase(
      params: LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(DataFailed(error: failure.message, uiEvent: UIEvent.loginPage)),
      (user) {
        _saveUserUseCase(params: user);
        emit(DataSuccess(data: user, uiEvent: UIEvent.loginPage));
      },
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<DataState> emit) async {
    _logoutUseCase();
  }
}
