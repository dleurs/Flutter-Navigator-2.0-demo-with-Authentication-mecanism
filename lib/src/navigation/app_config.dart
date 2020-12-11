import 'package:equatable/equatable.dart';

class AppConfig extends Equatable {
  final Uri uri;
  final int id;

  AppConfig.user()
      : uri = Uri(path: "/user"),
        id = null;

  AppConfig.book()
      : uri = Uri(path: "/book"),
        id = null;

  AppConfig.bookDetail(this.id) : uri = Uri(path: "/book/${id.toString()}");

  AppConfig.unknown()
      : uri = Uri(path: "/unknown"),
        id = null;

  bool get isUserSection => (uri == AppConfig.user().uri);

  bool get isBookSection => (uri == AppConfig.book().uri);

  bool get isBookDetailSection => (id != null);

  bool get isUnknown => (uri == AppConfig.unknown().uri);

  @override
  String toString() {
    return "AppConfig{ uriPath : " + uri.path + ", id : " + id.toString() + "}";
  }

  @override
  List<Object> get props => [uri.path, id];
}
