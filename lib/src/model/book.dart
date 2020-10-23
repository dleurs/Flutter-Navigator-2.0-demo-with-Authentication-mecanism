import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String title;
  final String author;

  Book(this.title, this.author);

  @override
  String toString() {
    return "Book : title = " + title + ", author = " + author;
  }

  @override
  List<Object> get props => [title, author];
}
