import 'package:flutter/material.dart';
import 'package:navigator_v2_flutter_with_auth/src/core/authentication/authentication_manager.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';
import 'package:navigator_v2_flutter_with_auth/src/navigation/my_router_delegate.dart';

class BooksListScreen extends StatelessWidget {
  final List<Book> books;

  BooksListScreen({
    @required this.books,
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
                (Router.of(context).routerDelegate as MyRouterDelegate)
                    .handleUserTapped(null);
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
                    onTap: () {
                      (Router.of(context).routerDelegate as MyRouterDelegate)
                          .handleBookTapped(book);
                    })
            ],
          ),
        ],
      ),
    );
  }
}
