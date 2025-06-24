import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/advertisement.dart';
import '../models/article.dart';

class MagazinePage extends StatefulWidget {
  final List<ArticleModel> articles;
  final List<AdvertisementModel> advertisements;

  const MagazinePage({
    Key? key,
    required this.articles,
    required this.advertisements,
  }) : super(key: key);

  @override
  _MagazinePageState createState() => _MagazinePageState();
}

class _MagazinePageState extends State<MagazinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 600,
        height: 800,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            // Background image with opacity
            Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/logo.png',
                width: 600,
                height: 800,
                fit: BoxFit.cover,
              ),
            ),

            // Articles
            ...widget.articles.expand((article) {
              List<Widget> widgets = [];

              widgets.add(
                Positioned(
                  left: article.contentCoordinates.left.toDouble(),
                  top: article.contentCoordinates.top.toDouble(),
                  width: article.contentCoordinates.width.toDouble(),
                  height: article.contentCoordinates.height.toDouble(),
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      article.content,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              );

              if (article.image.isNotEmpty) {
                widgets.add(
                  Positioned(
                    left: article.imageCoordinates.left.toDouble(),
                    top: article.imageCoordinates.top.toDouble(),
                    width: article.imageCoordinates.width.toDouble(),
                    height: article.imageCoordinates.height.toDouble(),
                    child: Image.memory(
                      base64Decode(article.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }

              return widgets;
            }).toList(),

            // Advertisements
            ...widget.advertisements.map((ad) {
              return Positioned(
                left: ad.imageCoordinates.left.toDouble(),
                top: ad.imageCoordinates.top.toDouble(),
                width: ad.imageCoordinates.width.toDouble(),
                height: ad.imageCoordinates.height.toDouble(),
                child: Image.memory(base64Decode(ad.image), fit: BoxFit.cover),
              );
            }),
          ],
        ),
      ),
    );
  }
}
