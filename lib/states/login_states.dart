class LoginState {
  const LoginState();
}

class LoginStateInitial extends LoginState {}
class LoginStateFailure extends LoginState {
  final String errorMessage;
  LoginStateFailure({required this.errorMessage});
}
class LoginStateSuccess extends LoginState {
  final String name;
  final String image;
  LoginStateSuccess({required this.name, required this.image});
}
class LoginEmptyState extends LoginState{}
