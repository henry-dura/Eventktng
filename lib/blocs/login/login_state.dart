// login_state.dart
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoaded extends LoginState {
  final String id;
  final String pass;
  final bool rememberMe;
  final bool obscureText;

  const LoginLoaded({
    required this.id,
    required this.pass,
    required this.rememberMe,
    this.obscureText = true,
  });

  LoginLoaded copyWith({
    String? id,
    String? pass,
    bool? rememberMe,
    bool? obscureText,
  }) {
    return LoginLoaded(
      id: id ?? this.id,
      pass: pass ?? this.pass,
      rememberMe: rememberMe ?? this.rememberMe,
      obscureText: obscureText ?? this.obscureText,
    );
  }

  @override
  List<Object> get props => [id, pass, rememberMe, obscureText];
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}
