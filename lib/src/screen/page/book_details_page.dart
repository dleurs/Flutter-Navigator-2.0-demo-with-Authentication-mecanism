import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';
import 'package:navigator_v2_flutter_with_auth/src/screen/book_details_screen.dart';

class BookDetailsPage extends Page {
  final Book book;
  final ValueChanged onTappedUser;

  BookDetailsPage({
    this.book,
    @required this.onTappedUser,
  }) : super(key: ValueKey(book));

  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BookDetailsScreen(
          book: book,
          onTappedUser: onTappedUser,
        );
      },
    );
  }
}