import 'package:books/bloc/favorite_books_bloc.dart';
import 'package:books/model/book_model.dart';
import 'package:books/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: favoriteBooksBloc.getStream,
        initialData: favoriteBooksBloc.favoriteBooks,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.data.length > 0
              ? Expanded(
                  child: ListView.builder(
                    addRepaintBoundaries: true,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final Book book = snapshot.data[index];
                      return BookTile(book: book);
                    },
                  ),
                )
              : const Center(
                  child: Text(
                    'Noch kein Favorit ausgewählt',
                    style: TextStyle(fontSize: 18),
                  ),
                );
        });
  }
}
