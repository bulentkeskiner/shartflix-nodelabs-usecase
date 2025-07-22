import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

/// İlk başlangıç durumu
class SplashInitial extends SplashState {}

/// Auth durumu kontrol ediliyor
class SplashLoading extends SplashState {}

/// Kullanıcı login olmuş → token var
class SplashAuthenticated extends SplashState {}

/// Kullanıcı login olmamış → token yok
class SplashUnauthenticated extends SplashState {}

/// Hata oluştu (isteğe bağlı)
class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}
