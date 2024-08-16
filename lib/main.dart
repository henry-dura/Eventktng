import 'package:flutter/material.dart';
import 'package:stadia_scanner/welcome_page.dart';


Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventng',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFF6600),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(double.infinity, 51)),
            iconSize: MaterialStateProperty.all(24),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 17)),
            elevation: MaterialStateProperty.all(8),
            backgroundColor: MaterialStateProperty.all(const Color(0xFFFF6600)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        brightness: Brightness.light,
      ),

      home: const WelcomePage(),
    );
  }
}
