// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
//
// import '../providers/constants.dart';
// import '../widgets/rounded_input_field.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'admin_page.dart';
//
// class News extends StatefulWidget {
//   const News({Key? key}) : super(key: key);
//
//   @override
//   _NewsState createState() => _NewsState();
// }
//
// class _NewsState extends State<News> {
//   @override
//   void initState() {
//     super.initState();
//     getMagazine();
//   }
//
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController contentController = TextEditingController();
//   final TextEditingController categoryController = TextEditingController();
//   String? image;
//   int? selectedMagazineId;
//   Map<int, String>? magazineMap;
//   final picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RoundedInputField(hintText: 'title', controller: titleController),
//           RoundedInputField(hintText: 'content', controller: contentController),
//           TextButton(
//             onPressed: getImage,
//             child: const Text("Upload cover image"),
//           ),
//           RoundedInputField(
//             hintText: 'category',
//             controller: categoryController,
//           ),
//           DropdownButton<int>(
//             hint: const Text("Magazine"),
//             value: selectedMagazineId,
//             items:
//                 magazineMap?.entries.map((entry) {
//                   return DropdownMenuItem<int>(
//                     value: entry.key,
//                     child: Text(entry.value),
//                   );
//                 }).toList(),
//             onChanged: (int? value) {
//               setState(() {
//                 selectedMagazineId = value;
//               });
//             },
//           ),
//           TextButton(onPressed: addNews, child: const Text("Add News")),
//         ],
//       ),
//     );
//   }
//
//   Future getImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       final bytes =
//           await pickedFile.readAsBytes(); // Works on both mobile and web
//       setState(() {
//         image = base64Encode(bytes);
//         print("Image base64: $image");
//       });
//     } else {
//       print("No image selected");
//     }
//   }
//
//   Future getMagazine() async {
//     try {
//       final uri = Uri.parse("$baseUrl/magazine/title");
//       var response = await http.get(uri);
//       Map<String, dynamic> body = json.decode(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           magazineMap = body.map(
//             (key, value) => MapEntry(int.parse(key), value.toString()),
//           );
//         });
//       }
//     } catch (e) {}
//   }
//
//   Future addNews() async {
//     final uri = Uri.parse("$baseUrl/news");
//     var request = jsonEncode({
//       "title": titleController.text,
//       "content": contentController.text,
//       "image": image,
//       "category": categoryController.text,
//       "magazineId": selectedMagazineId,
//     });
//     print(request);
//     Map<String, String> headers = {"Content-Type": "application/json"};
//     var response = await http.post(uri, body: request, headers: headers);
//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("News added"),
//           duration: Duration(seconds: 5),
//           behavior: SnackBarBehavior.floating, // Optional
//         ),
//       );
//       print(response);
//       Future.delayed(Duration(seconds: 1), () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const AdminPage()),
//         );
//       });
//     }
//   }
// }
