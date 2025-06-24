import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/constants.dart';


class MiddleRow2 extends StatefulWidget {
  const MiddleRow2({Key? key}) : super(key: key);

  @override
  _MiddleRow2State createState() => _MiddleRow2State();
}

class _MiddleRow2State extends State<MiddleRow2> {
  List magazines = [];
  @override
  void initState(){
    super.initState();
    getMagazine();
  }
  Future getMagazine() async{
    try{
      final uri = Uri.parse('$baseUrl/magazine');
      http.Response response = await http.get(uri
        //, headers:{HttpHeaders.authorizationHeader:"Bearer"+token
      );
      var body = json.decode(response.body);
      if(response.statusCode==200){
        magazines = body;
      }
    }

    catch(e){
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      color: Colors.grey[100],
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 20,),
          const Text(
            'Books & Resources',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 280, // Height of each book box
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: magazines.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        magazines[index]['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'A brief description or subtitle for the book can go here.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Link to book
                          },
                          child: const Text('Read'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}