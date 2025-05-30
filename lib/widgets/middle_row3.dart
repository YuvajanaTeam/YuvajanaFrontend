import 'package:flutter/material.dart';

class MiddleRow3 extends StatelessWidget {
  const MiddleRow3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> boxTitles = [
      'Category',
      'Scrolling',
      'Box 3',
      'Box 4',
      'Box 5',
      'Box 6',
      'Box 7',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.grey[100],
      height: 160, // height of the row
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = (constraints.maxWidth - (16 * 6)) / 5; // 5 boxes + 6 gaps

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: boxTitles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return Container(
                width: boxWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    boxTitles[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}