import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/constants.dart';

class PageContainer extends StatefulWidget {
  final int magazineId;
  final Function(String type, int pageId) onButtonClicked;

  const PageContainer({Key? key, required this.magazineId,
    required this.onButtonClicked,}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  List pages = [];
  int? expandedPageIndex;
  @override
  void initState() {
    super.initState();
    getPages(widget.magazineId);
  }

  @override
  void didUpdateWidget(covariant PageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.magazineId != widget.magazineId) {
      expandedPageIndex = null;
      getPages(widget.magazineId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // slightly wider for dropdown usability
      color: Colors.red[50],
      child: Column(
        children: [
          // Page list or "No Pages"
          Expanded(
            child: ListView.builder(
              itemCount: pages.isEmpty ? 1 : pages.length,
              itemBuilder: (context, index) {
                if (pages.isEmpty) {
                  return const ListTile(
                    title: Text('No Pages'),
                  );
                }
                final page = pages[index];
                final pageNumber = page['pageNumber'] ?? index + 1;
                bool isOpen = expandedPageIndex==index;
                return Container(
                  color: isOpen ? Colors.red[100] : Colors.transparent,
                  child: ExpansionTile(
                    key: index == expandedPageIndex ? UniqueKey() : ValueKey(index),
                    initiallyExpanded: isOpen,
                    title: Text('Page $pageNumber', style: const TextStyle(fontSize: 14)),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
                    onExpansionChanged: (expanded) {
                      setState(() {
                        expandedPageIndex = expanded ? index : null;
                      });
                    },
                    children: [
                      ListView.builder(
                        shrinkWrap: true, // Important when nesting inside another scrollable
                        physics: const NeverScrollableScrollPhysics(), // Prevent conflict with outer scroll
                        itemCount: page['articles'].length + page['advertisements'].length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < page['articles'].length) {
                            final article = page['articles'][index];
                            return ListTile(
                              leading: const Icon(Icons.article),
                              title: Text(article['title'] ?? 'Untitled Article'),
                              subtitle: Text('Type: Article'),
                            );
                          } else {
                            final adIndex = index - page['articles'].length;
                            final ad = page['advertisements'][adIndex];
                            return ListTile(
                              leading: const Icon(Icons.campaign),
                              title: Text(ad['title'] ?? 'Untitled Ad'),
                              subtitle: Text('Type: Advertisement'),
                            );
                          }
                        },
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onButtonClicked("Article", page['id']),
                        child: const Text('Add article'),
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onButtonClicked("News", page['id']),
                        child: const Text('Add News'),
                      ),
                      ElevatedButton(
                        onPressed: () => widget.onButtonClicked("Advertisement", page['id']),
                        child: const Text('Add Advertisement'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Add Page button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  int newPageNo = pages.isEmpty ? 1 : pages.length + 1;
                  addPage(newPageNo, widget.magazineId);
                },
                child: const Text("Add Page", style: TextStyle(fontSize: 12)),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Future<void> addPage(int pageNumber, int magazineId) async {
    try {
      final uri = Uri.parse('$baseUrl/page');
      var request = jsonEncode({ "pageNo": pageNumber,
        "magazineId": magazineId
      });
      Map<String, String> headers = {"Content-Type": "application/json"};
      var response = await http.post(uri, body:request, headers:headers);

      if (response.statusCode == 200) {
          getPages(magazineId);
        }
    }catch (e) {
      print("Error fetching pages: $e");
    }
  }
  Future<void> getPages(int magazineId) async {
    try {
      final uri = Uri.parse('$baseUrl/page/$magazineId');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body is List) {
          setState(() {
            pages = body;
          });
        }
      }
    }
    catch (e) {
      print("Error fetching pages: $e");
    }
  }
}
