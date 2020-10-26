import 'package:flutter/material.dart';

import 'package:navigator_v2_flutter_with_auth/src/model/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  final ValueChanged onTappedUser;

  BookDetailsScreen({
    @required this.book,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book.title, style: Theme.of(context).textTheme.headline6),
              Text(book.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}
