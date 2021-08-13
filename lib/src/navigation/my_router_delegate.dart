import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_state.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/home_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/settings_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/unknown_screen.dart';

class MyRouterDelegate extends RouterDelegate<AppState> with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppState> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppState currentState = HomeScreen.state;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    print('1. MyRouterDelegate initialized');
    assert(this.currentConfiguration == HomeScreen.state);
  }

  AppState get currentConfiguration => currentState;

  List<Page<dynamic>> buildPage() {
    List<Page<dynamic>> pages = [];
    // is shown even when currentState == null
    pages.add(
      MaterialPage(
        key: ValueKey(HomeScreen.state.hashCode),
        child: HomeScreen(),
      ),
    );
    if (currentState == SettingsScreen.state) {
      pages.add(MaterialPage(key: ValueKey(SettingsScreen.state.hashCode), child: SettingsScreen()));
    } else if (currentState == UnknownScreen.state) {
      pages.add(MaterialPage(key: ValueKey(UnknownScreen.state.hashCode), child: UnknownScreen()));
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    print("MyRouterDelegate building : " + this.currentState.toString());
    return Navigator(
      key: navigatorKey,
      pages: buildPage(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        currentState = HomeScreen.state;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppState newState) async {
    currentState = newState;
    return;
  }

  void toSettingsScreen() {
    currentState = SettingsScreen.state;
    notifyListeners();
  }

  void toHomeScreen() {
    currentState = HomeScreen.state;
    notifyListeners();
  }
}
