import 'package:flutter/material.dart';
import 'package:yuvav1/widgets/bottom_bar.dart';
import 'package:yuvav1/widgets/middle_row3.dart';
import '../widgets/top_bar.dart';
import '../widgets/middle_row1.dart';
import '../widgets/middle_row2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // This expands and scrolls if needed
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  TopBar(),
                  MiddleRow1(),
                  MiddleRow2(),
                  SizedBox(height: 30,),
                  MiddleRow3(),
                ],
              ),
            ),
          ),

          // Always sticks to the bottom
          const BottomBar(),
        ],
      ),
    );
  }
}