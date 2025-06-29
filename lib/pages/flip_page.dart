import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'package:http/http.dart' as http;

import '../models/advertisement.dart';
import '../models/article.dart';
import '../providers/constants.dart';
import 'magazine_pages.dart';

class FlipPage extends StatefulWidget {
  final int magazineId;

  const FlipPage({Key? key, required this.magazineId}) : super(key: key);

  @override
  _FlipPageState createState() => _FlipPageState();
}

class _FlipPageState extends State<FlipPage> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  // One list of pages, where each page has its own list of articles
  List<List<ArticleModel>> pagedArticles = [];
  Map<int, List<AdvertisementModel>> pagedAdvertisements = {};

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          pagedArticles.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  PageFlipWidget(
                    key: _controller,
                    backgroundColor: Colors.white,
                    lastPage: const Material(
                      child: Center(child: Text("End of Magazine")),
                    ),
                    children:
                        pagedArticles.map((articlesOnPage) {
                          final pageId = articlesOnPage.first.pageId;
                          final adsForPage = pagedAdvertisements[pageId] ?? [];
                          return Material(
                            child: MagazinePage(
                              articles: articlesOnPage,
                              advertisements: adsForPage,
                            ),
                          );
                        }).toList(),
                  ),

                  // ◀ Left Button
                  Positioned(
                    left: 16,
                    top: MediaQuery.of(context).size.height / 2 - 30,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 28),
                      onPressed: () => _controller.currentState?.previousPage(),
                    ),
                  ),

                  // ▶ Right Button
                  Positioned(
                    right: 16,
                    top: MediaQuery.of(context).size.height / 2 - 30,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 28),
                      onPressed: () => _controller.currentState?.nextPage(),
                    ),
                  ),
                ],
              ),
    );
  }

  Future<void> fetchArticles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/page/${widget.magazineId}'),
    );

    if (response.statusCode == 200) {
      final List pageList = jsonDecode(response.body);

      // Extract and flatten all articles and ads
      final allArticles =
          pageList.expand((page) => page['articles'] ?? []).toList();
      final allAds =
          pageList.expand((page) => page['advertisements'] ?? []).toList();

      // Group articles by pageId
      final Map<int, List<ArticleModel>> pageArticleMap = {};
      for (var articleJson in allArticles) {
        final article = ArticleModel.fromJson(articleJson);
        final pageId = article.pageId;
        pageArticleMap.putIfAbsent(pageId, () => []).add(article);
      }

      // Group advertisements by pageId
      final Map<int, List<AdvertisementModel>> pageAdMap = {};
      for (var adJson in allAds) {
        final ad = AdvertisementModel.fromJson(adJson);
        final pageId = ad.pageId; // Make sure `AdvertisementModel` has `pageId`
        pageAdMap.putIfAbsent(pageId, () => []).add(ad);
      }

      // Sort pages by pageId (or by page number if needed)
      final sortedPages =
          pageArticleMap.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key));

      // Store both in state (update your state class accordingly)
      setState(() {
        pagedArticles = sortedPages.map((entry) => entry.value).toList();
        pagedAdvertisements =
            pageAdMap; // Example: Map<int, List<AdvertisementModel>>
      });

      print('Loaded pages: ${pagedArticles.length}');
    }
  }
}
