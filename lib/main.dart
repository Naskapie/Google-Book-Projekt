import 'package:books/pages/favorites_page.dart';
import 'package:books/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const YuconBooks());
}

class YuconBooks extends StatefulWidget {
  const YuconBooks({Key? key}) : super(key: key);

  @override
  _YuconBooksState createState() => _YuconBooksState();
}

class _YuconBooksState extends State<YuconBooks> {
  @override
  Widget build(BuildContext context) {
    final myTabs = <Tab>[
      const Tab(text: 'Suche'),
      const Tab(text: 'Favoriten')
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Books'),
            centerTitle: true,
            bottom: TabBar(tabs: myTabs),
          ),
          body: const TabBarView(children: [
            SearchPage(),
            FavoritesPage(),
          ]),
        ),
      ),
    );
  }
}
