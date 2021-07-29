import 'package:books/model/book_model.dart';
import 'package:books/utils/json_services.dart';
import 'package:books/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final myController = TextEditingController();

  bool _isLoading = false;
  final List _books = <Book>[];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Future<void> googleBooks(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      _books.clear();
      return;
    }

    setState(() {
      _isLoading = true;
    });
    await fetchBooks(searchText).then((loadedBooks) {
      _books.addAll(loadedBooks
          .where((dynamic item) => item['volumeInfo']['title'] != null)
          .map<Book>((dynamic item) => Book.fromJson(item)));
      setState(() {
        _isLoading = false;
      });
    }).catchError((Object error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error $error'),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final banner = MaterialBanner(
      backgroundColor: const Color(0xFFFAFAFA),
      content: Padding(
        padding: const EdgeInsets.only(left: 12, bottom: 20, top: 20),
        child: SizedBox(
          height: 48,
          child: TextField(
            autofocus: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Titel, Autor, Stichwort',
            ),
            controller: myController,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _books.clear();
              });
              final searchText = myController.text;
              googleBooks(searchText);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(20, 48),
            ),
            child: const Text(
              'Suchen',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: banner,
            ),
          )
        ];
      },
      body: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ],
            )
          : _books.isNotEmpty
              ? ListView.builder(
                  addRepaintBoundaries: true,
                  shrinkWrap: true,
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final Book book = _books[index];
                    return BookTile(book: book);
                  },
                )
              : const Center(
                  child: Text('Jetzt Bücher entdecken!'),
                ),
    );
  }
}
