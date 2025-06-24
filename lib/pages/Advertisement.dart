import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../models/Coordinates.dart';
import '../models/advertisement.dart';
import '../providers/constants.dart';
import '../widgets/rounded_input_field.dart';
import 'admin_page.dart';

class Advertisement extends StatefulWidget {
  final void Function(AdvertisementModel advertisement) onReviewTap;
  final int pageId;
  const Advertisement({Key? key, required this.onReviewTap, required this.pageId}) : super(key: key);

  @override
  _AdvertisementState createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? image;
  int? selectedMagazineId;
  Map<int, String>? magazineMap;
  DateTime? startDate;
  DateTime? endDate;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getMagazine();
    print(widget.pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Advertisement")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Create Advertisement",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                RoundedInputField(
                  hintText: 'Title',
                  controller: titleController,
                ),
                const SizedBox(height: 12),
                RoundedInputField(
                  hintText: 'Description',
                  controller: descriptionController,
                ),
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
                const SizedBox(height: 12),
                _buildDatePickerTile(
                  label: "Start Date",
                  selectedDate: startDate,
                  onTap: () => selectDate(context, true),
                ),
                const SizedBox(height: 10),
                _buildDatePickerTile(
                  label: "End Date",
                  selectedDate: endDate,
                  onTap: () => selectDate(context, false),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text("Review Advertisement"),
                    onPressed: () {
                      final advertisment = AdvertisementModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        image: image ?? "",
                        imageCoordinates: Coordinates(
                          top: 300,
                          left: 100,
                          width: 150,
                          height: 150,
                        ),
                        pageId: widget.pageId ?? 1,
                        startDate:startDate!.millisecondsSinceEpoch,
                        endDate: endDate!.millisecondsSinceEpoch,
                      );
                      widget.onReviewTap(advertisment);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerTile({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        selectedDate != null
            ? "${selectedDate.toLocal()}".split(' ')[0]
            : "No date selected",
        style: TextStyle(
          color: selectedDate != null ? Colors.black : Colors.grey,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: onTap,
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

  Future getMagazine() async {
    try {
      final uri = Uri.parse("$baseUrl/magazine/title");
      var response = await http.get(uri);
      Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          magazineMap = body.map(
            (key, value) => MapEntry(int.parse(key), value.toString()),
          );
        });
      }
    } catch (e) {
      print("Error loading magazine list: $e");
    }
  }

  Future selectDate(BuildContext context, bool isStartDate) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = selectedDate;
        } else {
          endDate = selectedDate;
        }
      });
    }
  }
}
