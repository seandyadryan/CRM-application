import 'package:flutter/material.dart';

import 'controllers/crm_controller.dart';
import 'views/home_view.dart';

void main() {
  runApp(const CrmApplication());
}

class CrmApplication extends StatefulWidget {
  const CrmApplication({super.key});

  @override
  State<CrmApplication> createState() => _CrmApplicationState();
}

class _CrmApplicationState extends State<CrmApplication> {
  final CrmController controller = CrmController();

  @override
  void initState() {
    super.initState();
    controller.loadWorkspace();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
          secondary: const Color(0xFF14B8A6),
          tertiary: const Color(0xFFF59E0B),
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
        cardTheme: const CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: HomeView(controller: controller),
    );
  }
}
