import 'package:go_router/go_router.dart';

import '../pages/admin_page.dart';
import '../pages/contact_page.dart';
import '../pages/flip_page.dart';
import '../pages/gallery_page.dart';
import '../pages/home_page.dart';
import '../pages/temporary_flip_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/magazine',
      builder: (context, state) => const TemporaryFlipPage(),
    ),
    GoRoute(
        path: '/magazine/1',
        builder: (context, state) =>
            const TemporaryFlipPage(),
    ),
    GoRoute(
      path: '/gallery',
      builder: (context, state) => const GalleryPage(),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactUsPage(),
    ),
    GoRoute(
      path: '/magazine/2',
      builder: (context, state) => const FlipPage(magazineId: 1,),
    ),
  ],
);
