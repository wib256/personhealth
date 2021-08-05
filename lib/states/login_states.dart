class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {}
class LoginStateFailure extends LoginState {
  final String errorMessage;
  LoginStateFailure({required this.errorMessage});
}
class LoginStateSuccess extends LoginState {}
class LoginEmptyState extends LoginState{}
