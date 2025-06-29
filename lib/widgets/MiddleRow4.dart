import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiddleRow4 extends StatelessWidget {
  const MiddleRow4({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles = [
      {
        'title': 'Empowering Rural Youth',
        'subtitle':
        'A new government initiative is bringing skills training to remote villages, opening doors for rural youth.',
      },
      {
        'title': 'Tech in Agriculture',
        'subtitle':
        'Farmers are now using AI-powered apps to track crop health and optimize yield. A big leap forward for agri-tech.',
      },
      {
        'title': 'Startup Boom in Small Towns',
        'subtitle':
        'Small towns are becoming new hubs for innovation as young entrepreneurs find success away from metros.',
      },
      {
        'title': 'Education Reform',
        'subtitle':
        'Rural schools get digital classrooms and e-learning tools thanks to NGO and govt collaboration.',
      },
    ];

    final isDesktop = MediaQuery.of(context).size.width > 800;
    final double cardWidth = isDesktop ? 280 : 220;
    final double cardHeight = isDesktop ? 400 : 340;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '📰 Newspaper Highlights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: cardHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: articles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 24),
              itemBuilder: (context, index) {
                return Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        articles[index]['title']!,
                        style: GoogleFonts.merriweather(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          articles[index]['subtitle']!,
                          style: GoogleFonts.lora(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(60, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Read More'),
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