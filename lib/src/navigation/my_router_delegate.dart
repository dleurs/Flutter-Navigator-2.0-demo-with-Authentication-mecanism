import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/app_config.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/book_details_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/books_list_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/user_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/unknown_screen.dart';

class MyRouterDelegate extends RouterDelegate<AppConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfig> {
  final GlobalKey<NavigatorState> navigatorKey;

  AppConfig currentState = AppConfig.book();
  AppConfig previousState;
  // for pop on User Page, to possibly go back to a specific book

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    print("1. BookRouterDelegate initialized");
    print(this);
    assert(AppConfig.book() == this.currentConfiguration);
  }

  AppConfig get currentConfiguration {
    return currentState;
  }

  List<Page<dynamic>> buildPage() {
    List<Page<dynamic>> pages = [];
    pages.add(
      MaterialPage(
        key: ValueKey('BooksListPage'),
        child: BooksListScreen(
          books: books,
        ),
      ),
    );
    if (currentState.firstSection == UrlFirstSection.book() &&
        currentState.id != null) {
      pages.add(
        MaterialPage(
            key: ValueKey('BookListPageId' + currentState.id.toString()),
            child: BookDetailsScreen(book: books[currentState.id])),
      );
    }
    if (currentState.firstSection == UrlFirstSection.user()) {
      pages.add(MaterialPage(
          key: ValueKey('LoginScreen'),
          child: UserScreen(
            refresh: _notifyListeners,
          )));
    }
    if (currentState.isUnknown)
      pages.add(
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()));
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    print("BookRouterDelegate building...");
    print(this.currentState);
    return Navigator(
      key: navigatorKey,
      //transitionDelegate: AnimationTransitionDelegate(),
      pages: buildPage(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        } else if (currentState.firstSection == UrlFirstSection.book() &&
            currentState.id != null) {
          currentState = AppConfig.book();
        } else if (currentState.firstSection == UrlFirstSection.user()) {
          currentState = previousState;
          previousState = null;
        } else {
          currentState = AppConfig.unknown();
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppConfig newState) async {
    currentState = newState;
    return;
  }

  void handleBookTapped(Book book) {
    currentState = AppConfig.bookDetail(books.indexOf(book));
    notifyListeners();
  }

  void handleUserTapped(void nulll) {
    previousState = currentState;
    currentState = AppConfig.user();
    notifyListeners();
  }

  void _notifyListeners(void nothing) {
    notifyListeners();
  }
}
