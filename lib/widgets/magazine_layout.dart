import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/advertisement.dart';
import '../models/article.dart';
import '../widgets/draggable_resizable_item.dart';
import '../providers/constants.dart';

class MagazineLayout extends StatefulWidget {
  final List<ArticleModel> articles;
  final List<AdvertisementModel>? advertisements;
  final VoidCallback? onLayoutSaved;

  const MagazineLayout({Key? key, required this.articles, this.advertisements, this.onLayoutSaved})
      : super(key: key);

  @override
  State<MagazineLayout> createState() => _MagazineLayoutState();
}

class _MagazineLayoutState extends State<MagazineLayout> {
  final Map<int, GlobalKey<DraggableResizableItemState>> contentKeys = {};
  final Map<int, GlobalKey<DraggableResizableItemState>> titleKeys = {};
  final Map<int, GlobalKey<DraggableResizableItemState>> imageKeys = {};
  final Map<int, GlobalKey<DraggableResizableItemState>> adKeys = {};

  @override
  void initState() {
    print('Articles received in MagazineLayout: ${widget.articles.length}');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save Layout'),
              onPressed: () => saveAll(context),
            ),
          ),
          SizedBox(
            child: Center(
              child: Container(
                width: 600,
                height: 800,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    for (var article in widget.articles) ...[
                      DraggableResizableItem(
                        key: contentKeys.putIfAbsent(article.id ?? article.
                        hashCode, () => GlobalKey()),
                        content: article.content,
                        initialTop: article.contentCoordinates.top.toDouble(),
                        initialLeft: article.contentCoordinates.left.toDouble(),
                        initialWidth: article.contentCoordinates.width.toDouble(),
                        initialHeight: article.contentCoordinates.height.toDouble(),
                      ),
                      DraggableResizableItem(
                        key: titleKeys.putIfAbsent(article.id ?? article.
                        hashCode, () => GlobalKey()),
                        content: article.articleTitle,
                        initialTop: article.titleCoordinates.top.toDouble(),
                        initialLeft: article.titleCoordinates.left.toDouble(),
                        initialWidth: article.titleCoordinates.width.toDouble(),
                        initialHeight: article.titleCoordinates.height.toDouble(),
                      ),
                      if (article.image.isNotEmpty)
                        DraggableResizableItem(
                          key: imageKeys.putIfAbsent(
                              article.id ?? article.hashCode, () => GlobalKey()),
                          child: Image.memory(base64Decode(article.image)),
                          initialTop: article.imageCoordinates.top.toDouble(),
                          initialLeft: article.imageCoordinates.left.toDouble(),
                          initialWidth: article.imageCoordinates.width.toDouble(),
                          initialHeight: article.imageCoordinates.height
                              .toDouble(),
                        ),
                    ],
                    if (widget.advertisements != null)
                      for (var advertisement in widget.advertisements!)
                        ...[
                          DraggableResizableItem(
                            key: adKeys.putIfAbsent(advertisement.id ?? advertisement.hashCode, () => GlobalKey()),
                            initialTop: advertisement.imageCoordinates.top
                                .toDouble(),
                            initialLeft: advertisement.imageCoordinates.left
                                .toDouble(),
                            initialWidth: advertisement.imageCoordinates.width
                                .toDouble(),
                            initialHeight: advertisement.imageCoordinates.height
                                .toDouble(),
                            child: Image.memory(
                                base64Decode(advertisement.image)),
                          ),
                        ],
                  ],
                ),
              ),
            ),
          )
          ,
        ]
        ,
      ),
    );
  }


  Future<void> saveAll(BuildContext context) async {
    bool allSuccess = true;

    for (var article in widget.articles) {
      final contentState =
          contentKeys[article.id ?? article.hashCode]?.currentState;
      final titleState =
          titleKeys[article.id ?? article.hashCode]?.currentState;
      final imageState =
          imageKeys[article.id ?? article.hashCode]?.currentState;

      if (contentState == null || titleState == null) continue;
      print("Title: ${article.articleTitle}");
      print("TitleKey: ${titleKeys[article.id ?? article.hashCode]}");
      print("Title top: ${titleState?.getTop()}");
      print("Title left: ${titleState?.getLeft()}");
      print("Title width: ${titleState?.getWidth()}");
      print("Title height: ${titleState?.getHeight()}");
      final articleData = {
        "id": article.id,
        "articleTitle": article.articleTitle,
        "shortDescription": article.shortDescription,
        "subCategory": article.subCategory,
        "content": article.content,
        "language": article.language,
        "pageId": article.pageId,
        "author": article.author,
        "image": article.image,
        "titleCoordinates": {
          "top": titleState.getTop(),
          "left": titleState.getLeft(),
          "width": titleState.getWidth(),
          "height": titleState.getHeight(),
        },
        "contentCoordinates": {
          "top": contentState.getTop(),
          "left": contentState.getLeft(),
          "width": contentState.getWidth(),
          "height": contentState.getHeight(),
        },
        "imageCoordinates": imageState != null
            ? {
          "top": imageState.getTop(),
          "left": imageState.getLeft(),
          "width": imageState.getWidth(),
          "height": imageState.getHeight(),
        }
            : {"top": 0, "left": 0, "width": 0, "height": 0},
      };

      final uri = Uri.parse('$baseUrl/content');
      final headers = {"Content-Type": "application/json"};
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(articleData),
      );

      if (response.statusCode != 200) {
        allSuccess = false;
      }
    }

    // 👉 Save advertisement (if present)
    if (widget.advertisements != null) {
      for (var ad in widget.advertisements!) {
        final adState = adKeys[ad.id ?? ad.hashCode]?.currentState;
        if (adState != null) {
          final adData = {
            "id": ad.id,
            "title": ad.title,
            "description": ad.description,
            "image": ad.image,
            "pageId": ad.pageId,
            "startDate": ad.startDate,
            "endDate": ad.endDate,
            "imageCoordinates": {
              "top": adState.getTop(),
              "left": adState.getLeft(),
              "width": adState.getWidth(),
              "height": adState.getHeight(),
            },
          };

          final adUri = Uri.parse('$baseUrl/advertisement');
          final adHeaders = {"Content-Type": "application/json"};
          final adResponse = await http.post(
            adUri,
            headers: adHeaders,
            body: jsonEncode(adData),
          );

          if (adResponse.statusCode != 200) {
            allSuccess = false;
          }
        }
      }
    }
    if (allSuccess) {
      widget.onLayoutSaved?.call(); // trigger fetchArticles from MainContent
    }
    // ✅ Result message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(allSuccess
            ? "All content saved successfully"
            : "Some content failed to save"),
      ),
    );
  }

}
