import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/my_route_path.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/page/book_details_page.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/books_list_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/user_screen.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/unknown_screen.dart';

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  MyRoutePath currentState = MyRoutePath.book();
  MyRoutePath previousState;
  // for pop on User Page, to possibly go back to a specific book

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    print("1. BookRouterDelegate initialized");
    print(this);
    assert(MyRoutePath.book() == this.currentConfiguration);
  }

  MyRoutePath get currentConfiguration {
    return currentState;
  }

  List<Page<dynamic>> buildPage() {
    List<Page<dynamic>> pages = [];
    pages.add(
      MaterialPage(
        key: ValueKey('BooksListPage'),
        child: BooksListScreen(
          books: books,
          onTappedBook: _handleBookTapped,
          onTappedUser: _handleUserTapped,
        ),
      ),
    );

    if (currentState.firstSection == FirstSection.book()) {
      if (currentState.id != null)
        pages.add(BookDetailsPage(
            book: books[currentState.id], onTappedUser: _handleUserTapped));
    } else if (currentState.firstSection == FirstSection.user()) {
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
      pages: buildPage(),
      onPopPage: (route, result) {
        print("onPopPage");
        print(this.currentState);
        if (!route.didPop(result)) {
          return false;
        } else if (currentState.firstSection == FirstSection.book() &&
            currentState.id != null) {
          currentState = MyRoutePath.book();
        } else if (currentState.firstSection == FirstSection.user()) {
          currentState = previousState;
          previousState = null;
        } else {
          currentState = MyRoutePath.unknown();
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    if (path.isUnknown) {
      currentState = MyRoutePath.unknown();
      return;
    }

    if (path.isUserSection) {
      currentState = MyRoutePath.user();
    }

    if (path.isBookSection) {
      if (path.isBookDetailSection) {
        if (path.id < 0 || path.id > books.length - 1) {
          currentState = MyRoutePath.unknown();
          return;
        }
        currentState = MyRoutePath.bookDetail(path.id);
      } else {
        currentState = MyRoutePath.book();
      }
    }
  }

  void _handleBookTapped(Book book) {
    currentState = MyRoutePath.bookDetail(books.indexOf(book));
    notifyListeners();
  }

  void _handleUserTapped(void nothing) {
    previousState = currentState;
    currentState = MyRoutePath.user();
    notifyListeners();
  }

  void _notifyListeners(void nothing) {
    notifyListeners();
  }
}
