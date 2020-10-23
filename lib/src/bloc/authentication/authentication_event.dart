import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}
