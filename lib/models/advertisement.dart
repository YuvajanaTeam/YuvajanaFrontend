import 'Coordinates.dart';

class AdvertisementModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final Coordinates imageCoordinates;
  final int pageId;
  final int startDate;
  final int endDate;

  AdvertisementModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.imageCoordinates,
    required this.pageId,
    required this.startDate,
    required this.endDate,
  });

  factory AdvertisementModel.fromJson(Map<dynamic, dynamic> json) {
    return AdvertisementModel(
      id:json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      imageCoordinates: Coordinates.fromJson(json['imageCoordinates']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      pageId: json['pageId'],
    );
  }
}
