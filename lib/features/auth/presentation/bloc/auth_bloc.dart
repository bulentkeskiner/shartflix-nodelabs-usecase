import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/core/resources/data_state.dart';
import 'package:shartflix/features/auth/domain/entities/login_params.dart';
import 'package:shartflix/features/auth/domain/entities/register_params.dart';
import 'package:shartflix/features/auth/domain/use_cases/login_use_case.dart';
import 'package:shartflix/features/auth/domain/use_cases/register_use_case.dart';
import 'package:shartflix/features/auth/presentation/bloc/auth_event.dart';
import 'package:shartflix/features/splash/domain/usecases/save_user_use_case.dart';

class AuthBloc extends Bloc<AuthEvent, DataState> {
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  final SaveUserUseCase _saveUserUseCase;

  AuthBloc(this._registerUseCase, this._loginUseCase, this._saveUserUseCase)
    : super(DataInitial()) {
    on<RegisterSubmitted>(_onRegister);
    on<LoginSubmitted>(_onLogin);
  }

  Future<void> _onRegister(RegisterSubmitted event, Emitter<DataState> emit) async {
    emit(DataLoading());

    final result = await _registerUseCase(
      params: RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(DataFailed(error: failure.message)),
      (user) => emit(DataSuccess(data: user)),
    );
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<DataState> emit) async {
    emit(DataLoading());

    final result = await _loginUseCase(
      params: LoginParams(email: event.email, password: event.password),
    );

    result.fold((failure) => emit(DataFailed(error: failure.message)), (user) {
      _saveUserUseCase(params: user);
      emit(DataSuccess(data: user));
    });
  }
}
