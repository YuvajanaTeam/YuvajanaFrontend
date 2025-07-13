import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class MiddleRow4 extends StatelessWidget {
  const MiddleRow4({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> articles = [
      {
        'title':
            'The Role of the Church in Sustaining and Nurturing Discipleship',
        'subtitle':
            'The church has long been a cornerstone of Christian faith, providing a '
            'community of believers who come together to worship, learn, and '
            'support one another. But is the church essential for sustaining '
            'and nurturing discipleship? Let'
            's explore this topic with biblical'
            ' insights.',
      },
      {
        'title': 'Christian Discipleship in Present-Day Society',
        'subtitle':
            'The Holy Bible introduced us to the concept of discipleship within '
            'a specific historical context. Applying discipleship to today’s '
            'modern world may seem challenging—but is it? People were '
            'complicated then, just as we are now. One key difference is '
            'that we have gadgets that make life easier.',
      },
      {
        'title': 'എന്താണ് മിന്നൽ വള ?',
        'subtitle':
            '1980 മുതൽ പാട്ടെഴുതി നമ്മെ വിസ്മയിപ്പിക്കുകയും ഒപ്പം നമ്മൾ '
            'മൂളിപാടുകയും ചെയ്ത മനോഹര ഗാനങ്ങൾ രചിച്ച കൈതപ്രം '
            'ദാമോദരൻ നമ്പൂതിരി മിന്നൽ വള എന്ന ഗാന രചനയിലൂടെ 2025 ലും'
            ' നമ്മെ വിസ്മയിപ്പിക്കുന്നു. എവിടെ തിരിഞ്ഞാലും മിന്നൽ വളയും '
            'അതിൻ്റെ പാരഡി ഗാനങ്ങളാലും സമൂഹ മാധ്യമങ്ങൾ സമ്പന്നമാണ്. ',
      },
      {
        'title': 'സഭയും രാഷ്ട്രീയവും',
        'subtitle':
            'മുമ്പ് നടന്ന ഒരു  യുവജന പ്രസ്ഥാനത്തിൻ്റെ Chandigarh ഇൽ വച്ച് നടന്ന '
            'conference ൽ പങ്കെടുക്കുവാൻ ഇടയായി. അവിടെ കോൺഫറൻസ് ന് '
            'നേതൃത്ത്വം കൊടുക്കാൻ വന്ന കാതോലിക്ക സഭയിലെ അച്ഛൻ ഒരു '
            'question ചോദിച്ചു എന്താണ് സഭ ?',
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
              '📰 Magazine Highlights',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
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
                          onPressed: () => GoRouter.of(context).go('/magazine/1'),
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
