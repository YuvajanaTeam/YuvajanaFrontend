import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final menuItems = {
      'Home': '/',
      'Magazine': '/magazine',
      'Gallery': '/gallery',
      'Contact Us': '/contact',
    };

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: isMobile
          ? Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Hamburger icon on the left
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black),
            onSelected: (route) => context.go(route),
            itemBuilder: (context) => menuItems.entries
                .map(
                  (entry) => PopupMenuItem<String>(
                value: entry.value,
                child: Text(entry.key),
              ),
            )
                .toList(),
          ),
          const SizedBox(width: 16),
          _buildLogoTitle(isMobile),
        ],
      )
          : Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLogoTitle(isMobile),
            const SizedBox(width: 32),
            Row(
              children: menuItems.entries
                  .map(
                    (entry) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () => context.go(entry.value),
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoTitle(bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/logo.png', width: 40, height: 40),
        const SizedBox(width: 8),
        Text(
          'YUVAJANASHABDAM',
          style: TextStyle(
            fontSize: isMobile? 18: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
