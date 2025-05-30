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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.facebookF, color: Colors.white),
            onPressed: () => _launchURL('https://facebook.com/yourpage'),
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.xTwitter, color: Colors.white),
            onPressed: () => _launchURL('https://x.com/yourpage'),
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
          const SizedBox(width: 16),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.linkedinIn, color: Colors.white),
            onPressed: () => _launchURL('https://linkedin.com/in/yourprofile'),
          ),
        ],
      ),
    );
  }
}