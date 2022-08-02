import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navigator_v2_flutter_with_auth/src/bloc/authentication/authentication_event.dart';
import 'package:navigator_v2_flutter_with_auth/src/bloc/authentication/authentication_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/core/authentication/authentication_manager.dart';
import 'package:navigator_v2_flutter_with_auth/src/resource/login_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginRepository _repository;


  AuthenticationBloc(this._repository) : super(InitialAuthenticationState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginEvent) {
        if (await _repository.login()) {
          AuthenticationManager.instance.isLoggedIn = true;
          emit(AuthenticationSuccessState());
        } else {
          AuthenticationManager.instance.isLoggedIn = false;
          emit(AuthenticationErrorState(error: 'Login failed'));
        }
      }
      if (event is LogoutEvent) {
        await _repository.logout();
        AuthenticationManager.instance.isLoggedIn = false;
        emit(LoggedOutState());
      }
    });
  }

}
