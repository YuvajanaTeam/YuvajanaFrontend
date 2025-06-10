import 'package:flutter/material.dart';
import 'package:yuvav1/widgets/MiddleRow4.dart';
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
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            // Main content area that scrolls
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    MiddleRow1(),
                    MiddleRow2(),
                    SizedBox(height: 30),
                    MiddleRow3(),
                    MiddleRow4(),
                    BottomBar(),
                  ],
                ),
              ),
            ),
            // BottomBar(),
          ],
        ),
      ),
    );
  }
}
