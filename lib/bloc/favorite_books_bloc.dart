import 'dart:async';
import 'package:books/model/book_model.dart';

final favoriteBooksBloc = FavoriteBooksBloc();

class FavoriteBooksBloc {
  final favoriteStreamController = StreamController.broadcast();
  Stream get getStream => favoriteStreamController.stream;

  final List favoriteBooks = [];

  void addToFavorites(Book book) {
    favoriteBooks.add(book);
    favoriteStreamController.sink.add(favoriteBooks);
  }

  void removeFromFavorites(Book book) {
    favoriteBooks.remove(book);
    favoriteStreamController.sink.add(favoriteBooks);
  }

  void dispose() {
    favoriteStreamController.close();
  }
}
