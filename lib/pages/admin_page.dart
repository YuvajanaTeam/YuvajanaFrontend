import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

import '../config/size_config.dart';
import '../providers/constants.dart';
import '../widgets/main_content.dart';
import '../widgets/page_container.dart';
import 'Magazine.dart';
import 'flip_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List magazines = [];
  bool showMagazineScreen = false;
  int? selectedMagazineId;

  String? selectedType;
  int? selectedPageId;

  void _onPageButtonSelected(String type, int pageId) {
    setState(() {
      selectedType = type;
      selectedPageId = pageId;
    });
  }

  @override
  void initState() {
    super.initState();
    getMagazine();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            // Navigate to home or perform an action
            // Navigator.of(context).pushAndRemoveUntil(
            //   MaterialPageRoute(
            //     builder: (BuildContext context) => FlipPage(magazineId: 1),
            //   ),
            //   (Route<dynamic> route) => false,
            //);
            GoRouter.of(context).go('/magazine/2');
          }, // or any route
        ),
        title: Text('Admin Page'),
      ),
      body: Row(
        children: [
          // Left pane: Magazine list
          Container(
            width: 200,
            color: Colors.red[100],
            child: Column(
              children: [
                // const DrawerHeader(
                //   decoration: BoxDecoration(color: Colors.red),
                //   child: Text('Magazines', style: TextStyle(color: Colors.white)),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: magazines.length,
                    itemBuilder: (context, index) {
                      final magazine = magazines[index];
                      final isSelected = selectedMagazineId == magazine['id'];

                      return Container(
                        color:
                            isSelected ? Colors.red[300] : Colors.transparent,
                        child: ListTile(
                          title: Text(
                            magazine['title'] ?? 'No Title',
                            style: TextStyle(
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              showMagazineScreen = true;
                              selectedMagazineId = magazine['id'];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed:
                      () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 60,
                              child: Magazine(onMagazineAdded: getMagazine),
                            ),
                          );
                        },
                      ),
                  child: const Text("Add magazine"),
                ),
              ],
            ),
          ),

          // Middle pane: PageContainer (Fixed width)
          if (showMagazineScreen)
            PageContainer(
              magazineId: selectedMagazineId!,
              onButtonClicked: _onPageButtonSelected,
            ),

          // Right pane: Main content area
          Expanded(
            child:
                selectedType != null && selectedPageId != null
                    ? MainContent(
                      type: selectedType!,
                      pageId: selectedPageId!,
                      magazineId: selectedMagazineId,
                    )
                    : const Center(child: Text("Select a page action")),
          ),
        ],
      ),
    );
  }

  Future<void> getMagazine() async {
    try {
      final uri = Uri.parse('$baseUrl/magazine');
      http.Response response = await http.get(uri);
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          magazines = body;
        });
      }
    } catch (e) {
      print("Error fetching magazines: $e");
    }
  }
}
