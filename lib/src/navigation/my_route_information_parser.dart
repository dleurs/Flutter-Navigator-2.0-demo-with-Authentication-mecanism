import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/navigation/app_config.dart';

class MyRouteInformationParser extends RouteInformationParser<AppConfig> {
  @override
  Future<AppConfig> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    // Handle '/' and '/book'
    if (uri.pathSegments.length == 0 ||
        (uri.pathSegments.length == 1 && uri.pathSegments[0] == AppConfig.book().uri.pathSegments[0])) {
      return AppConfig.book();
    }

    if ((uri.pathSegments.length == 1 && uri.pathSegments[0] == AppConfig.user().uri.pathSegments[0])) {
      return AppConfig.user();
    }

    // Handle '/book/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == AppConfig.book().uri.pathSegments[0]) {
        var remaining = uri.pathSegments[1];
        var id = int.tryParse(remaining);
        if (id == null) return AppConfig.unknown();
        return AppConfig.bookDetail(id);
      }
    }

    // Handle unknown routes
    return AppConfig.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppConfig path) {
    if (path.isUnknown) {
      return RouteInformation(location: AppConfig.unknown().uri.path);
    }
    if (path.isBookSection) {
      return RouteInformation(location: AppConfig.book().uri.path);
    }
    if (path.isBookDetailSection) {
      return RouteInformation(location: AppConfig.bookDetail(path.id).uri.path);
    }
    if (path.isUserSection) {
      return RouteInformation(location: AppConfig.user().uri.path);
    }
    return RouteInformation();
  }
}
