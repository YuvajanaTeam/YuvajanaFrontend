import 'package:flutter/material.dart';

import '../providers/constants.dart' as Constants;

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Constants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
                  isMobile
                      ? _buildContactSection(context)
                      : Row(
                        children: [
                          Expanded(child: _buildInfoSection(context)),
                          const SizedBox(width: 40),
                          Expanded(child: _buildContactSection(context)),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get in Touch',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'We would love to hear from you. Whether you have a question, feedback or just want to say hello.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 32),
        const ListTile(
          leading: Icon(Icons.email, color: Constants.primaryColor),
          title: Text('yuvajanashabdham@gmail.com'),
        ),
        const ListTile(
          leading: Icon(Icons.phone, color: Constants.primaryColor),
          title: Text('+91 95409 62922'),
        ),
        const ListTile(
          leading: Icon(Icons.location_on, color: Constants.primaryColor),
          title: Text('Delhi, India'),
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our team',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'This app is a dream work of our team',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 32),
        const ListTile(
          leading: Text("Editor-in-Chief:"),
          title: Text('Fr. Joji Kurien Thomas'),
        ),
        const ListTile(
          leading: Text("Coordinator"),
          title: Text('Mr. Lijo Varghese'),
        ),
        const ListTile(
          leading: Text("Sub Editors:"),
          title: Text('Ms. Sruthimol Baby & Ms. Ciya Biju'),
        ),
        const ListTile(
          leading: Text("Co-Editors:"),
          title: Text(
            'Mr. Ninan Lukose, Mrs. Smitha Thomas,  Justin A. Mathew',
          ),
        ),
        const ListTile(
          leading: Text("Print & Design Head:"),
          title: Text('Mr. Georgy Ninan'),
        ),
        const ListTile(
          leading: Text("Media Cordinators :"),
          title: Text('Mr. Renji Daniel & Rinju Varghese'),
        ),
        const ListTile(
          leading: Text("Finance & \nSponsorship  Head:"),
          title: Text(
            'Mr. Tinu Thomas, Mr. Lijo Varghese, Mr. Ashwin Skaria, Justin A. Mathew',
          ),
        ),
        const ListTile(
          leading: Text("Finance Cordinators:"),
          title: Text(
            'Ms. Sneha S Jacob, Mr. Sijo Cherian, Ms. Preenu Punnoose',
          ),
        ),
        const ListTile(
          leading: Text("Website Building:"),
          title: Text(
            'Mr. Jeffin M Benny, Mrs. Suma Aby, Mr. Nikhil S Thomas, Mr. Bijith Varghese',
          ),
        ),
      ],
    );
  }
}
