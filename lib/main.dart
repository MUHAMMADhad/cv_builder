import 'package:flutter/material.dart';
import 'screens/form_screen.dart';

void main() => runApp(const CVBuilderApp());

class CVBuilderApp extends StatelessWidget {
  const CVBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4F6AF5),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0F2FF),
      ),
      home: const FormScreen(),
    );
  }
}
