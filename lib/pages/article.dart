import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/size_config.dart';
import '../models/Coordinates.dart';
import '../providers/constants.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/rounded_input_field.dart';
import 'admin_page.dart';
import '../models/article.dart';

class Article extends StatefulWidget {
  final void Function(ArticleModel article) onReviewTap;
  final int pageId;
  const Article({Key? key, required this.onReviewTap, required this.pageId}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController subCategoryController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController languageController = TextEditingController();

  Map<int, String>? magazineMap;
  int? selectedMagazineId;
  String? image;

  final picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    //getMagazine();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Add Article")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "New Article",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RoundedInputField(
                    hintText: 'Title',
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  RoundedInputField(
                    hintText: 'Short Description',
                    controller: shortDescriptionController,
                  ),
                  const SizedBox(height: 10),
                  RoundedInputField(
                    hintText: 'Subcategory',
                    controller: subCategoryController,
                  ),
                  const SizedBox(height: 10),
                  RoundedInputField(
                    hintText: 'Content',
                    controller: contentController,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: getImage,
                    icon: const Icon(Icons.upload),
                    label: const Text("Upload Cover Image"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (image != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Image Selected",
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  RoundedInputField(
                    hintText: 'Language',
                    controller: languageController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 20,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text("Review Article"),
                      onPressed: () {
                        final article = ArticleModel(
                          articleTitle: titleController.text,
                          shortDescription: shortDescriptionController.text,
                          subCategory: subCategoryController.text,
                          content: contentController.text,
                          image: image ?? "",
                          contentCoordinates: Coordinates(top: 400, left: 100, width: 150, height: 150),
                          imageCoordinates: Coordinates(top: 450, left: 100, width: 150, height: 150),
                          language: languageController.text,
                          author: "", // or get it from session/user
                          pageId: widget.pageId ?? 1,
                        );
                        widget.onReviewTap(article);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        image = base64Encode(bytes);
      });
    }
  }

}
