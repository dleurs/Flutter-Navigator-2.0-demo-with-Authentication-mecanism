import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/navigation/my_route_path.dart';

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    // Handle '/' and '/book'
    if (uri.pathSegments.length == 0 ||
        (uri.pathSegments.length == 1 &&
            uri.pathSegments[0] == UrlFirstSection.book().name)) {
      return MyRoutePath.book();
    }

    if ((uri.pathSegments.length == 1 &&
        uri.pathSegments[0] == UrlFirstSection.user().name)) {
      return MyRoutePath.user();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == UrlFirstSection.book().name) {
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return MyRoutePath.unknown();
        return MyRoutePath.bookDetail(id);
      }
    }

    // Handle unknown routes
    return MyRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isBookSection) {
      if (path.isBookDetailSection)
        return RouteInformation(
            location: '/' + UrlFirstSection.book().urlName + '/${path.id}');
      else
        return RouteInformation(location: '/' + UrlFirstSection.book().urlName);
    }
    if (path.isUserSection) {
      return RouteInformation(location: '/' + UrlFirstSection.user().urlName);
    }

    return null;
  }
}
