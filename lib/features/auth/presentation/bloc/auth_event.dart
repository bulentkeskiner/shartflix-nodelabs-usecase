class AuthEvent {
  const AuthEvent();
}

class RegisterSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});
}
