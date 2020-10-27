import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Section extends Equatable {
  final String name;
  final String path;

  Section({@required this.name, @required this.path});

  String toString() {
    return "Section, name = " + name + ", path = " + path;
  }

  @override
  List<Object> get props => [name, path];
}

class FirstSection extends Section {
  FirstSection.book() : super(name: "book", path: "/book");
  FirstSection.user() : super(name: "user", path: "/user");
}

class SecondSection extends Section {}

class UserSecondSection extends Section {}

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
