import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/advertisement.dart';
import '../models/article.dart';
import '../pages/Advertisement.dart';
import '../pages/article.dart';
import '../providers/constants.dart';
import 'magazine_layout.dart';
import 'package:http/http.dart' as http;

class MainContent extends StatefulWidget {
  final String type;
  final int pageId;
  final int? magazineId;
  const MainContent({ Key? key,required this.magazineId, required this.type, required this.pageId }) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ArticleModel> articles = [];
  List<AdvertisementModel> advertisements = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchContent();

    _tabController.addListener(() async {
      if (!_tabController.indexIsChanging && _tabController.index == 1) {
        if (articles.isEmpty) {
          await fetchContent();
          if (articles.isEmpty) {
            _tabController.animateTo(0);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No article to review yet")),
            );
          }
        }
      }
    });
  }
  void onReviewAdTap(AdvertisementModel ad) {
    setState(() {
      advertisements.removeWhere((a) => a.title == ad.title); // use unique field like `id` if available
      advertisements.insert(0, ad);
    });
    _tabController.animateTo(1);
  }

  Future<void> fetchContent() async {
    final response = await http.get(Uri.parse('$baseUrl/page/${widget.magazineId}'));
    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      if (list.isNotEmpty) {
        // Flatten all articles
        final List allArticles = list.expand((page) => page['articles'] ?? []).toList();
        final fetched = allArticles.map((a) => ArticleModel.fromJson(a)).toList();

        // Flatten all advertisements
        final List allAds = list.expand((page) => page['advertisements'] ?? []).toList();
        final fetchedAds = allAds.map((a) => AdvertisementModel.fromJson(a)).toList();

        setState(() {
          articles = fetched.where((a) => a.pageId == widget.pageId).toList();
          advertisements = fetchedAds.where((ad) => ad.pageId == widget.pageId).toList();
        });
      }
    }
  }



  void onReviewTap(ArticleModel article) {
    setState(() {
      // Add or replace in local list for live preview
      articles.removeWhere((a) => a.id == article.id);
      articles.insert(0, article); // new one at top
    });
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(controller: _tabController, tabs: [Tab(text: 'Input'), Tab(text: 'Review')]),
      Expanded(
        child: TabBarView(controller: _tabController, children: [
          widget.type == 'Article'
              ? Article(pageId: widget.pageId, onReviewTap: onReviewTap)
              : Advertisement(pageId: widget.pageId, onReviewTap: onReviewAdTap),
          MagazineLayout(articles: articles, advertisements: advertisements, onLayoutSaved: fetchContent,),
        ]),
      ),
    ]);
  }
}

