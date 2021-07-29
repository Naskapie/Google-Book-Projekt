import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchBooks(String searchText) async {
  final uri = 'https://www.googleapis.com/books/v1/volumes?q=$searchText';

  final response = await http.get(Uri.parse(uri));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['items'];
  } else {
    throw Exception('Failed to load book');
  }
}
