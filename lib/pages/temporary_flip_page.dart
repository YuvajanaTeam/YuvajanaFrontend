import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_flip/page_flip.dart';
import 'package:http/http.dart' as http;

import '../models/advertisement.dart';
import '../models/article.dart';
import '../providers/constants.dart';
import 'magazine_pages.dart';

class TemporaryFlipPage extends StatefulWidget {

  const TemporaryFlipPage({Key? key}) : super(key: key);

  @override
  _TemporaryFlipPageState createState() => _TemporaryFlipPageState();
}

class _TemporaryFlipPageState extends State<TemporaryFlipPage> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  // One list of pages, where each page has its own list of articles
  List<int> pageIds = [];
  Map<int, List<AdvertisementModel>> pagedAdvertisements = {};

  @override
  void initState() {
    super.initState();
    pageIds = List.generate(5, (i) => i + 1); // Pages 1 to 5
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
                children: [
                  PageFlipWidget(
                    key: _controller,
                    backgroundColor: Colors.white,
                    lastPage: const Material(
                      child: Center(child: Text("End of Magazine")),
                    ),
                    children: pageIds.map((pageId) {
                      return Material(
                        child: Center(
                          child: Image.asset(
                            'assets/Page$pageId.PNG',
                            fit: BoxFit.contain,
                          ),
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
}
