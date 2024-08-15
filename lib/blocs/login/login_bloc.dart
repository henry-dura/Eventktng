// login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../secrets/secret.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SharedPreferences prefs;

  LoginBloc({required this.prefs}) : super(LoginInitial()) {
    on<LoadUserCredentials>(_onLoadUserCredentials);
    on<RememberMeChanged>(_onRememberMeChanged);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<ToggleObscureText>(_onToggleObscureText);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onLoadUserCredentials(
      LoadUserCredentials event, Emitter<LoginState> emit) {
    final rememberMe = prefs.getBool('rememberMe') ?? false;
    final userName = rememberMe ? prefs.getString('userName') ?? '' : '';
    final pass = rememberMe ? prefs.getString('pass') ?? '' : '';

    emit(LoginLoaded(userName: userName, pass: pass, rememberMe: rememberMe));
  }

  void _onRememberMeChanged(
      RememberMeChanged event, Emitter<LoginState> emit) {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      emit(currentState.copyWith(rememberMe: event.rememberMe));
    }
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    if (event.userName == secretUserName && event.pass == secretPassword) {
      if (state is LoginLoaded) {
        final currentState = state as LoginLoaded;
        await prefs.setBool('rememberMe', currentState.rememberMe);
        if (currentState.rememberMe) {
          await prefs.setString('userName', event.userName);
          await prefs.setString('pass', event.pass);
        } else {
          await prefs.remove('userName');
          await prefs.remove('pass');
        }
      }
      emit(LoginSuccess());
    } else {
      emit(LoginFailure());
    }
  }

  void _onToggleObscureText(ToggleObscureText event, Emitter<LoginState> emit) {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      emit(currentState.copyWith(obscureText: !currentState.obscureText));
    }
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      emit(currentState.copyWith(pass: event.password));
    }
  }
}
