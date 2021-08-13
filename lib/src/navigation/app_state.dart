import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final Uri uri;
  final String name;

  AppState({required this.uri, required this.name});

  @override
  String toString() {
    String str = "appConfig{ ";
    str += "uri.path: " + uri.path + ", ";
    str += "name: " + name;
    str += " }";
    return str;
  }

  @override
  List<Object> get props => [uri];
}
