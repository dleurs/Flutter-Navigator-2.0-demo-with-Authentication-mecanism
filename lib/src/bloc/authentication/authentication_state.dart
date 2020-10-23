import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {
  @override
  String toString() {
    return 'InitialAuthenticationState';
  }
}

class AuthenticationProcessingState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationProcessingState';
  }
}

class AuthenticationSuccessState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationSuccessState';
  }
}

class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState({this.error});

  @override
  String toString() {
    return 'AuthenticationErrorState';
  }
}

class LoggedOutState extends AuthenticationState {
  @override
  String toString() {
    return 'LoggedOutState';
  }
}
