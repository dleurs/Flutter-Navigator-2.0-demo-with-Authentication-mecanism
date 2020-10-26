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

  // Should be the same as
  // setNewRoutePath(parseRouteInformation(routeInformation.location='/'))
  // like MyRoutePath.book(). assert in constructor
  bool show404 = false;
  FirstSection firstSection = FirstSection.book();
  SecondSection secondSection;
  Book _selectedBook;

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
    if (show404) {
      return MyRoutePath.unknown();
    }
    if (firstSection == FirstSection.book()) {
      return (_selectedBook == null)
          ? MyRoutePath.book()
          : MyRoutePath.bookDetail(books.indexOf(_selectedBook));
    } else if (firstSection == FirstSection.user()) {
      return MyRoutePath.user();
    }
    return MyRoutePath.unknown();
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

    if (firstSection == FirstSection.book()) {
      if (_selectedBook != null)
        pages.add(BookDetailsPage(
            book: _selectedBook, onTappedUser: _handleUserTapped));
    } else if (firstSection == FirstSection.user()) {
      pages.add(MaterialPage(
          key: ValueKey('LoginScreen'),
          child: UserScreen(
            refresh: _refresh,
          )));
    }
    if (show404)
      pages.add(
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen()));
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    print("BookRouterDelegate building...");
    print(this);
    return Navigator(
      key: navigatorKey,
      pages: buildPage(),
      onPopPage: (route, result) {
        print("onPopPage");
        print(this);
        if (!route.didPop(result)) {
          return false;
        } else if (firstSection == FirstSection.book() &&
            _selectedBook != null) {
          _selectedBook = null;
        } else if (firstSection == FirstSection.user()) {
          firstSection = FirstSection.book();
        }
        show404 = false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath path) async {
    if (path.isUnknown) {
      show404 = true;
      firstSection = null;
      secondSection = null;
      _selectedBook = null;
      return;
    }

    if (path.isUserSection) {
      firstSection = FirstSection.user();
    }

    if (path.isBookSection) {
      firstSection = FirstSection.book();
      if (path.isBookDetailSection) {
        if (path.id < 0 || path.id > books.length - 1) {
          show404 = true;
          return;
        }
        _selectedBook = books[path.id];
      } else {
        _selectedBook = null;
      }
    }
    show404 = false;
  }

  @override
  String toString() {
    String str = "BookRouterDelegate : show404 = " + show404.toString();
    str += ", firstSection = " + firstSection.toString();
    str += ", secondSection = " + secondSection.toString();
    str += ", _selectedBook = " + _selectedBook.toString();
    return str;
  }

  void _handleBookTapped(Book book) {
    _selectedBook = book;
    notifyListeners();
  }

  void _handleUserTapped(dynamic nothing) {
    firstSection = FirstSection.user();
    notifyListeners();
  }

  void _refresh(dynamic nothing) {
    notifyListeners();
  }
}
