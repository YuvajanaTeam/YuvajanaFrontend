import 'package:flutter/material.dart';
import 'dart:ui'; // for ImageFilter
import 'package:go_router/go_router.dart';

import '../pages/flip_page.dart';

class MiddleRow2 extends StatelessWidget {
  const MiddleRow2({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> magazines = List.generate(
      1,
      (i) => {'image': 'assets/mag1.png', 'title': 'Magazine ${i + 1}'},
    );

    final isDesktop = MediaQuery.of(context).size.width > 800;
    final double magazineWidth = isDesktop ? 250 : 180;
    final double magazineHeight = isDesktop ? 350 : 200;
    const double verticalSpacing = 8;

    final double totalCardHeight = (magazineHeight) + verticalSpacing;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.grey[100],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Books & Resources',
              style: TextStyle(
                fontSize: isDesktop ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: totalCardHeight,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate((magazines.length / 2).ceil(), (index) {
                  final int first = index * 2;
                  final int second = first + 1;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: magazineWidth,
                    child: Column(
                      children: [
                        _buildMagazineCard(
                          context,
                          magazines[first]['image']!,
                          magazines[first]['title']!,
                          magazineWidth,
                          magazineHeight,
                        ),
                        SizedBox(height: verticalSpacing),
                        if (second < magazines.length)
                          _buildMagazineCard(
                            context,
                            magazines[second]['image']!,
                            magazines[second]['title']!,
                            magazineWidth,
                            magazineHeight,
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMagazineCard(
    BuildContext context,
    String imgPath,
    String title,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () {
        //GoRouter.of(context).go('/magazine/1');
        GoRouter.of(context).go('/magazine/1');
      },
      child: Stack(
        children: [
          // Image Container
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage('assets/Page1.PNG'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 4,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
          ),

          // Blur overlay
          // Positioned.fill(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(6),
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          //       child: Container(
          //         color: Colors.black.withOpacity(0.4),
          //         alignment: Alignment.center,
          //         child: Center(
          //           child: Text(
          //             textAlign: TextAlign.center,
          //             "Edition 1 \nCOMING SOON",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold,
          //               letterSpacing: 2,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // Optional: title hover overlay if needed
          // HoverOverlay(title: title, width: width, height: height),
        ],
      ),
    );
  }
}

class HoverOverlay extends StatefulWidget {
  final String title;
  final double width;
  final double height;

  const HoverOverlay({
    super.key,
    required this.title,
    required this.width,
    required this.height,
  });

  @override
  State<HoverOverlay> createState() => _HoverOverlayState();
}

class _HoverOverlayState extends State<HoverOverlay> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedOpacity(
        opacity: _hovering ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
