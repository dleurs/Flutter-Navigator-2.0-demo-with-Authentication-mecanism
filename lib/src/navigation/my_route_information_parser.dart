import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/home_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/settings_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/unknown_screen.dart';

class MyRouteInformationParser extends RouteInformationParser<AppState> {
  @override
  Future<AppState> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return HomeScreen.state;
    }
    // Handle '/details'
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] == SettingsScreen.state.uri.pathSegments[0]) {
        return SettingsScreen.state;
      }
    }
    // Handle unknown routes
    return UnknownScreen.state;
  }

  @override
  RouteInformation restoreRouteInformation(AppState state) {
    if (state == UnknownScreen.state) {
      return RouteInformation(location: UnknownScreen.state.uri.path);
    }
    if (state == HomeScreen.state) {
      return RouteInformation(location: HomeScreen.state.uri.path);
    }
    if (state == SettingsScreen.state) {
      return RouteInformation(location: SettingsScreen.state.uri.path);
    }
    return RouteInformation();
  }
}
