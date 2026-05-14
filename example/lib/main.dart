import 'package:flutter/material.dart';
import 'package:cv_builder/cv_builder.dart';

void main() => runApp(const CVBuilderExampleApp());

class CVBuilderExampleApp extends StatelessWidget {
  const CVBuilderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Builder Example',
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