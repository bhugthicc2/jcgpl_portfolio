import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcgpl_portfolio/shell/pages/main_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'jcgpl_portfolio',
      initialRoute: '/',
      onGenerateRoute: (settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const MainPage(),
      ),
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
    );
  }
}
