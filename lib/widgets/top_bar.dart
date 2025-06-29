import 'package:flutter/material.dart';

import '../pages/login.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: TextField
            // SizedBox(
            //   width: 200,
            //   height: 40,
            //   // child: TextField(
            //   //   decoration: InputDecoration(
            //   //     hintText: 'Type here',
            //   //     border: OutlineInputBorder(),
            //   //     contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            //   //   ),
            //   // ),
            // ),

            // Center: Logo + Title
            Row(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 40, height: 40),
                const SizedBox(width: 8),
                const Flexible(
                  child: Text(
                    'YUVAJANSHABDAM',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(width:32),
            TextButton(onPressed: () {}, child: const Text("Home",
                style:TextStyle(fontWeight:FontWeight.bold, color:Colors.grey))),
            TextButton(onPressed: () {}, child: const Text("Magazine",
                style:TextStyle(fontWeight:FontWeight.bold, color:Colors.grey))),
            TextButton(onPressed: () {}, child: const Text("Articles",
                style:TextStyle(fontWeight:FontWeight.bold, color:Colors.grey))),
            TextButton(onPressed: () {}, child: const Text("Gallery",
                style:TextStyle(fontWeight:FontWeight.bold, color:Colors.grey))),
            TextButton(onPressed: () {}, child: const Text("Contact Us",
                style:TextStyle(fontWeight:FontWeight.bold, color:Colors.grey))),
            // Right: Buttons
            // Wrap(
            //   spacing: 8,
            //   children: [
            //     IconButton(
            //       icon: const Icon(Icons.search),
            //       onPressed: () {},
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => const LoginPage()),
            //         );
            //       },
            //       child: const Text('Sign In'),
            //     ),
            //     TextButton(
            //       onPressed: () {},
            //       child: const Text('Sign Up'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
