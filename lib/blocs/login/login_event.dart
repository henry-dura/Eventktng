// login_event.dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoadUserCredentials extends LoginEvent {}

class RememberMeChanged extends LoginEvent {
  final bool rememberMe;

  const RememberMeChanged(this.rememberMe);

  @override
  List<Object> get props => [rememberMe];
}

class LoginButtonPressed extends LoginEvent {
  final String id;
  final String pass;

  const LoginButtonPressed({required this.id, required this.pass});

  @override
  List<Object> get props => [id, pass];
}

class ToggleObscureText extends LoginEvent {}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}
