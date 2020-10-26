import 'package:equatable/equatable.dart';

class FirstSection extends Equatable {
  final String name;
  final String path;
  //final bool needsAuthentication;
  FirstSection.book()
      : name = "book",
        path = "/book"; // not /book because it is initial page
  FirstSection.user()
      : name = "user",
        path = "/user";

  @override
  String toString() {
    return "FirstSection : name = " + name + ", path = " + path;
  }

  @override
  List<Object> get props => [name, path];
}

abstract class SecondSection extends Equatable {
  final String name;
  final String path;

  SecondSection(this.name, this.path);

  @override
  String toString() {
    return "SecondSection : name = " + name + ", path = " + path;
  }

  @override
  List<Object> get props => [name, path];
}

extension UserSection on SecondSection {}

class MyRoutePath extends Equatable {
  final bool isUnknown;
  final FirstSection firstSection;
  final SecondSection secondSection;
  final int id;

  MyRoutePath.user()
      : isUnknown = false,
        firstSection = FirstSection.user(),
        secondSection = null,
        id = null;

  MyRoutePath.book()
      : isUnknown = false,
        firstSection = FirstSection.book(),
        secondSection = null,
        id = null;

  MyRoutePath.bookDetail(this.id)
      : isUnknown = false,
        firstSection = FirstSection.book(),
        secondSection = null;

  MyRoutePath.unknown()
      : isUnknown = true,
        firstSection = null,
        secondSection = null,
        id = null;

  bool get isUserSection => (firstSection == FirstSection.user());

  bool get isBookSection => (firstSection == FirstSection.book());

  bool get isBookDetailSection => (isBookSection && id != null);

  @override
  String toString() {
    return "MyRoutePath : isUnknown = " +
        isUnknown.toString() +
        ", firstSection = " +
        firstSection.toString() +
        ", secondSection = " +
        secondSection.toString() +
        ",id = " +
        id.toString();
  }

  @override
  List<Object> get props => [isUnknown, firstSection, secondSection, id];
}
