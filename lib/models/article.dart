import 'Coordinates.dart';

class ArticleModel {
  final int? id;
  final String articleTitle;
  final String shortDescription;
  final String subCategory;
  final String content;
  final String image;
  final Coordinates titleCoordinates;
  final Coordinates contentCoordinates;
  final Coordinates imageCoordinates;
  final String language;
  final String author;
  final int pageId;

  ArticleModel({
    this.id,
    required this.articleTitle,
    required this.shortDescription,
    required this.subCategory,
    required this.content,
    required this.image,
    required this.titleCoordinates,
    required this.contentCoordinates,
    required this.imageCoordinates,
    required this.language,
    required this.author,
    required this.pageId,
  });

  factory ArticleModel.fromJson(Map<dynamic, dynamic> json) {
    return ArticleModel(
      id:json['id'],
      articleTitle: json['articleTitle'],
      shortDescription: json['shortDescription'],
      subCategory: json['subCategory'],
      content: json['content'],
      image: json['image'],
      titleCoordinates: Coordinates.fromJson(json['titleCoordinates']),
      contentCoordinates: Coordinates.fromJson(json['contentCoordinates']),
      imageCoordinates: Coordinates.fromJson(json['imageCoordinates']),
      language: json['language'],
      author: json['author'],
      pageId: json['pageId'],
    );
  }

  @override
  String toString() {
    return 'ArticleModel(title: $articleTitle, author: $author, pageId: $pageId)';
  }
}
