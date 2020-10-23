class MyRoutePath {
  final int id;
  final bool isUnknown;

  MyRoutePath.home()
      : id = null,
        isUnknown = false;

  MyRoutePath.details(this.id) : isUnknown = false;

  MyRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
