import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTappedBook;
  final ValueChanged<Book> onTappedUser;

  BooksListScreen({
    @required this.books,
    @required this.onTappedBook,
    @required this.onTappedUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(
            icon: Icon(Icons.logout), onPressed: () => onTappedUser(null))
      ]),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTappedBook(book),
            )
        ],
      ),
    );
  }
}
