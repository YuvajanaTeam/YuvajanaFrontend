import 'package:flutter/material.dart';
import 'package:yuvav1/pages/admin_page.dart';
import 'package:yuvav1/pages/flip_page.dart';
import 'package:yuvav1/pages/temporary_flip_page.dart';
import 'package:yuvav1/providers/router.dart';
import 'pages/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/magazine/1',
      builder: (context, state) {
        return TemporaryFlipPage();
      },
    ),
  ],
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}