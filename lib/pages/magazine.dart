import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../providers/constants.dart';
import '../widgets/rounded_input_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


import 'admin_page.dart';

class Magazine extends StatefulWidget {
  final VoidCallback onMagazineAdded;
  const Magazine({Key? key, required this.onMagazineAdded}) : super(key: key);

  @override
  _MagazineState createState() => _MagazineState();
}

class _MagazineState extends State<Magazine> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController issueNumberController = TextEditingController();
  String? coverImage;
  String? status;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(hintText: 'title',
              controller: titleController,),
            RoundedInputField(hintText: 'issue Number',
              controller: issueNumberController,),
            const SizedBox(height: 20),
            TextButton(onPressed:getImage, child: const Text("Upload cover image"),),
            const SizedBox(height: 20),
            SizedBox(
                width: SizeConfig.blockSizeHorizontal * 50,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Status",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                hint: const Text('Status'),
                value: status,
                items: ['PUBLISHED', 'ARCHIVE', 'DRAFT'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed:()=>Navigator.pop(context), child: const Text("Cancel"),),
                  TextButton(onPressed:addMagzine, child: const Text("Add Magazine"),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Works on both mobile and web
      setState(() {
        coverImage = base64Encode(bytes);
        print("Image base64: $coverImage");
      });
    } else {
      print("No image selected");
    }
  }


  Future addMagzine() async{
    final uri = Uri.parse("$baseUrl/magazine");
    var request = jsonEncode({ "title": titleController.text,
        "issueNumber": issueNumberController.text,
        "coverImage": coverImage,
         "status":status});
    print(request);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http.post(uri, body:request, headers:headers);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Magazine added"),
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating, // Optional
        ),
      );
      print(response);
      widget.onMagazineAdded();
      Navigator.pop(
          context
        );
    }
  }
}
