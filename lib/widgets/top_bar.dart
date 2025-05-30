import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        if (isSmallScreen) {
          // 📱 Mobile layout: stacked
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Text Field
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Logo + Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Flexible(
                      child: Text(
                        'YUVAJANSHABDAM',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Buttons
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Sign In'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // 🖥️ Desktop/tablet layout: horizontal
          return Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                // Left: TextField
                SizedBox(
                  width: 200,
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    ),
                  ),
                ),

                const Spacer(),

                // Center: Logo + Title
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'YUVAJANSHABDAM',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Right: Buttons
                Wrap(
                  spacing: 8,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Sign In'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}