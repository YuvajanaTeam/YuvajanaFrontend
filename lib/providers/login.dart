import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../pages/admin_page.dart';
import 'constants.dart';

Future login(BuildContext context, String email, String password) async {
  final uri = Uri.parse("$baseUrl/user/signIn");
  final request = jsonEncode({"userName": email, "password": password});
  Map<String, String> headers = {"Content-Type": "application/json"};
  var response = await http.post(uri, body: request, headers: headers);
  var jsonResponse = json.decode(response.body);
  if (jsonResponse['status'] == 200) {
    print(jsonResponse);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => AdminPage()),
            (Route<dynamic> route) => false);
  }
}
