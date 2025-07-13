import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/constants.dart' as Constants;

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  final List<String> imagePaths = const [
    'assets/st_thomas.jpg',
    'assets/Saint_Peter.jpg',
    'assets/StMary.jpg',
    'assets/mar_baselios_mar_gregorios.jpg',
    'assets/Jesus_christ.jpg',
    'assets/resurrectionjpg.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        screenWidth > 900
            ? 4
            : screenWidth > 600
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Constants.primaryColor,
        leading: IconButton(onPressed: ()=>GoRouter.of(context).go('/'), icon: const Icon(Icons.arrow_back))
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: imagePaths.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return _buildImageTile(context, imagePaths[index]);
          },
        ),
      ),
    );
  }

  Widget _buildImageTile(BuildContext context, String path) {
    return InkWell(
      onTap: () => _showFullImage(context, path),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(path, fit: BoxFit.cover),
            if (!isMobile(context))
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: 0.2,
                  duration: const Duration(milliseconds: 200),
                  child: Container(color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFullImage(BuildContext context, String path) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(path),
                ),
              ),
            ),
          ),
    );
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
}
