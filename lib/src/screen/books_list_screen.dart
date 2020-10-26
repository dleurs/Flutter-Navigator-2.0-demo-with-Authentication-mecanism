import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/core/authentication/authentication_manager.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTappedBook;
  final ValueChanged onTappedUser;

  BooksListScreen({
    @required this.books,
    @required this.onTappedBook,
    @required this.onTappedUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.portrait,
              ),
              onPressed: () {
                onTappedUser(null);
              })
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AuthenticationManager.instance.isLoggedIn
                  ? "You are connected"
                  : "You are not connected",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              for (var book in books)
                ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () => onTappedBook(book),
                )
            ],
          ),
        ],
      ),
    );
  }
}
