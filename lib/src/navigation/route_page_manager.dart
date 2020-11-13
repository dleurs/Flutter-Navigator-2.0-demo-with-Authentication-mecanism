import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/books_list_screen.dart';
import 'package:provider/provider.dart';

// Taken from https://github.com/orestesgaolin/navigator_20_example main_router.dart

class RoutePageManager extends ChangeNotifier {
  static RoutePageManager of(BuildContext context) {
    return Provider.of<RoutePageManager>(context, listen: false);
  }

  List<Page> get pages => List.unmodifiable(_pages);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<Page> _pages = [
    MaterialPage(child: BooksListScreen(), key: const Key('MainScreen'), name: '/'),
  ];

  TheAppPath get currentPath {
    return parseRoute(Uri.parse(_pages.last.name));
  }

  void didPop(Page page) {
    _pages.remove(page);
    notifyListeners();
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    if (configuration.isUnknown) {
      // Handling 404
      _pages.add(
        MaterialPage(
          child: UnknownScreen(),
          key: UniqueKey(),
          name: '/404',
        ),
      );
    } else if (configuration.isDetailsPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: DetailsScreen(id: configuration.id),
          key: UniqueKey(),
          name: '/details/${configuration.id}',
        ),
      );
    } else if (configuration.isHomePage) {
      // Restoring to MainScreen
      _pages.removeWhere(
        (element) => element.key != const Key('MainScreen'),
      );
    }
    notifyListeners();
    return;
  }