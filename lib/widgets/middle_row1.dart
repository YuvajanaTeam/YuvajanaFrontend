import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/constants.dart';

class MiddleRow1 extends StatelessWidget {
  const MiddleRow1({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Container(
      height:
          isDesktop
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.4,
      color: primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: () async {
              //     final uri = Uri.parse("http://google.com");
              //     if (await canLaunchUrl(uri)) {
              //       await launchUrl(uri, mode: LaunchMode.externalApplication);
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text('Could not launch URL')),
              //       );
              //     }
              //   },
              //   child: SizedBox(
              //     height: MediaQuery.of(context).size.height / 4,
              //     child: Image.asset('assets/StMary.jpg', fit: BoxFit.contain),
              //   ),
              // ),
              Text(
                '“The youth is the hope of our future.”',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '- José Rizal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
