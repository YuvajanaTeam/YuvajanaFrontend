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

  final Map<String, String> fontMap = {
    'Christian Discipleship ': 'Lobster',
    'Christian Identity': 'Raleway',
    'Spiritual Growth': 'DancingScript',
    'Faith Over Followers': 'PlayfairDisplay',
    'Divine pillars': 'Montserrat',
    'Timeless Discipleship': 'Lobster',
    'Courageous Faith of St Thomas': 'Raleway',
    "സഭയും സമാധാനവും": 'DancingScript',
    "സഭയും രാഷ്ട്രീയവും": 'PlayfairDisplay',
    "ആത്മീയ ബാല്യം": 'Montserrat',
  };

  // final List<String> boxTitles = [
  //   'Christian Discipleship ',
  //   'Christian Identity',
  //   'Spiritual Growth',
  //   'Faith Over Followers',
  //   'Divine pillars',
  //   'Timeless Discipleship',
  //   'Courageous Faith of St Thomas',
  //   "സഭയും സമാധാനവും",
  //   "സഭയും രാഷ്ട്രീയവും",
  //   "ആത്മീയ ബാല്യം"
  // ];

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
    final entries = fontMap.entries.toList(); // Convert map to list of entries

    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;

        final double boxWidth =
        screenWidth < 900
            ? screenWidth / 2
            : (constraints.maxWidth - (12 * 6)) / 6;

        return ListView.separated(
          controller: controller,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: entries.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final title = entries[index].key;
            final font = entries[index].value;

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
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        fontFamily: font,
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
          SizedBox(height: 80, child: _buildAutoScrollRow(_scrollController1)),
          const SizedBox(height: 16),
          SizedBox(height: 80, child: _buildAutoScrollRow(_scrollController2)),
        ],
      ),
    );
  }
}
