import 'dart:async';
import 'package:flutter/material.dart';

class MiddleRow3 extends StatefulWidget {
  const MiddleRow3({super.key});

  @override
  State<MiddleRow3> createState() => _MiddleRow3State();
}

class _MiddleRow3State extends State<MiddleRow3> {
  late final ScrollController _scrollController1;
  late final ScrollController _scrollController2;
  Timer? _scrollTimer1;
  Timer? _scrollTimer2;

  final List<String> boxTitles = [
    'Category',
    'Scrolling',
    'Box 3',
    'Box 4',
    'Box 5',
    'Box 6',
    'Box 7',
    'Box 8',
    'Box 9',
    'Box 10',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll(_scrollController1, forward: true);
      _startAutoScroll(_scrollController2, forward: false);
    });
  }

  void _startAutoScroll(ScrollController controller, {required bool forward}) {
    const step = 1.5;
    const interval = Duration(milliseconds: 50);

    Timer timer = Timer.periodic(interval, (_) {
      if (!controller.hasClients) return;

      final maxScroll = controller.position.maxScrollExtent;
      final current = controller.offset;
      double next = forward ? current + step : current - step;

      if (forward && next >= maxScroll) {
        next = 0;
      } else if (!forward && next <= 0) {
        next = maxScroll;
      }

      controller.jumpTo(next);
    });

    if (forward) {
      _scrollTimer1 = timer;
    } else {
      _scrollTimer2 = timer;
    }
  }

  @override
  void dispose() {
    _scrollTimer1?.cancel();
    _scrollTimer2?.cancel();
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  Widget _buildAutoScrollRow(ScrollController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;

        // Fixed box width for small screens, responsive on larger screens
        final double boxWidth = screenWidth < 900
            ? 140
            : (constraints.maxWidth - (12 * 6)) / 6;

        return ListView.separated(
          controller: controller,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: boxTitles.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle box tap
              },
              child: MouseRegion(
                child: Container(
                  width: boxWidth,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      boxTitles[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          SizedBox(height: 120, child: _buildAutoScrollRow(_scrollController1)),
          const SizedBox(height: 16),
          SizedBox(height: 120, child: _buildAutoScrollRow(_scrollController2)),
        ],
      ),
    );
  }
}