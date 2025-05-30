import 'package:flutter/material.dart';

class MiddleRow2 extends StatelessWidget {
  const MiddleRow2({super.key});

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
              itemCount: 10,
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
                        'Book Title ${index + 1}',
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