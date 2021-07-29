import 'package:equatable/equatable.dart';

class Book {
  Book({
    required this.title,
    required this.id,
    required this.author,
    required this.description,
    required this.subtitle,
    required this.thumbnailURL,
    this.isFavorite = false,
  });

  final String title;
  final String id;
  final String author;
  final String description;
  final String subtitle;
  final String thumbnailURL;
  bool isFavorite;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['volumeInfo']['title'] as String,
        id: json['id'],
        author: (json['volumeInfo']['authors'])?.join(', ') ?? 'No author',
        description: (json['volumeInfo']['description']) ?? '',
        subtitle: (json['volumeInfo']['subtitle']) ?? '',
        thumbnailURL: json['volumeInfo']['imageLinks'] != null
            ? json['volumeInfo']['imageLinks']['smallThumbnail']
            : '');
  }
}
