import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Social Media Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
                onPressed: () => _launchURL("https://www.facebook.com/share/15XB2mVHmo/?mibextid=qi2Omg"),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
                onPressed: () => _launchURL('https://youtube.com/yourchannel'),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram, color: Colors.white),
                onPressed: () => _launchURL('https://instagram.com/yourpage'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.white24),
          const SizedBox(height: 8),
          // Copyright Text
          Text(
            '© 2025 Yuvajanashabdam All rights reserved.',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}