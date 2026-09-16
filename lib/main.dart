import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const FantasySoccerApp());
}

class FantasySoccerApp extends StatelessWidget {
  const FantasySoccerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Soccer League',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const DashboardPage(),
    );
  }
}
