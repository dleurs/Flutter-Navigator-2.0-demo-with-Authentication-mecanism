import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UrlSection extends Equatable {
  final String name;
  final String urlName;

  UrlSection({@required this.name, @required this.urlName});

  String toString() {
    return "Section{name:" + name + ",path:" + urlName + "}";
  }

  @override
  List<Object> get props => [name, urlName];
}

class UrlFirstSection extends UrlSection {
  UrlFirstSection.book() : super(name: "book", urlName: "book");
  UrlFirstSection.user() : super(name: "user", urlName: "user");
}

class UrlSecondSection extends UrlSection {}

class UrlSecondSectionUser extends UrlSection {}

class AppConfig extends Equatable {
  final bool isUnknown;
  final UrlFirstSection firstSection;
  final UrlSecondSection secondSection;
  final int id;

  AppConfig.user()
      : isUnknown = false,
        firstSection = UrlFirstSection.user(),
        secondSection = null,
        id = null;

  AppConfig.book()
      : isUnknown = false,
        firstSection = UrlFirstSection.book(),
        secondSection = null,
        id = null;

  AppConfig.bookDetail(this.id)
      : isUnknown = false,
        firstSection = UrlFirstSection.book(),
        secondSection = null;

  AppConfig.unknown()
      : isUnknown = true,
        firstSection = null,
        secondSection = null,
        id = null;

  bool get isUserSection => (firstSection == UrlFirstSection.user());

  bool get isBookSection => (firstSection == UrlFirstSection.book());

  bool get isBookDetailSection => (isBookSection && id != null);

  @override
  String toString() {
    return "AppState{ isUnknown : " +
        isUnknown.toString() +
        ", firstSection : " +
        firstSection.toString() +
        ", secondSection : " +
        secondSection.toString() +
        ", id : " +
        id.toString() +
        "}";
  }

  @override
  List<Object> get props => [isUnknown, firstSection, secondSection, id];
}
