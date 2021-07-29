import 'package:books/bloc/favorite_books_bloc.dart';
import 'package:books/model/book_model.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: CustomListTile(
        thumbnail: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(book.thumbnailURL)),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        id: book.id,
        author: book.author,
        title: book.title,
        subtitle: book.subtitle,
        description: book.description,
        isFavorite: book.isFavorite,
        checkbox: RoundedCheckbox(book: book),
      ),
    );
  }
}

class RoundedCheckbox extends StatefulWidget {
  const RoundedCheckbox({
    Key? key,
    required this.book,
    this.onStarred,
  }) : super(key: key);

  final Book book;
  final void Function()? onStarred;

  @override
  State<RoundedCheckbox> createState() => _RoundedCheckboxState();
}

class _RoundedCheckboxState extends State<RoundedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: Key('WorkoutItem__${widget.book.id}__Checkbox'),
      value: widget.book.isFavorite,
      onChanged: (bool? value) {
        setState(() {
          widget.book.isFavorite = value!;
        });
        value!
            ? favoriteBooksBloc.addToFavorites(widget.book)
            : favoriteBooksBloc.removeFromFavorites(widget.book);
      },
    );
  }
}

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    Key? key,
    required this.thumbnail,
    required this.id,
    required this.author,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.isFavorite,
    required this.checkbox,
  }) : super(key: key);

  final Widget thumbnail;
  final String id;
  final String author;
  final String title;
  final String subtitle;
  final String description;
  final bool isFavorite;
  final Widget checkbox;

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 80.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
            ),
            AspectRatio(
              aspectRatio: 1,
              child: widget.thumbnail,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                      child: _Description(
                        author: widget.author,
                        title: widget.title,
                        subtitle: widget.subtitle,
                        description: widget.description,
                        isFavorite: widget.isFavorite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                  widget.checkbox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.author,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.isFavorite,
  }) : super(key: key);

  final String author;
  final String title;
  final String subtitle;
  final String description;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  author,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0),
              ),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
