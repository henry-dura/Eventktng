import 'package:flutter/material.dart';
import 'package:stadia_scanner/welcomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MongoDatabase mongoDb = MongoDatabase();
  // await mongoDb.connect();
  // User user1 = User(
  //   name: 'Henry IKF',
  //   regId: '127',
  //   entryTime: '09:00',
  //   exitTime: '19:00',
  //   isCheckedIn: 'true',
  //   isCheckedOut: 'false',
  // );
  // //await mongoDb.insert(user1);
  // //print('User 1 added successfully');
  // MongoDatabase.update(
  //     regId: '123',
  //     isInEntryMode: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFF6600),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          // labelStyle: const TextStyle(color: Colors.white),
          // floatingLabelStyle: const TextStyle(color: Colors.deepPurpleAccent),
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
      //TODO: Change Email and pass
      //TODO: Remove DebugPrints
      //TODO: Separate sensitive info
      //TODO: Setup write/fetch guard
      //TODO: Enable Database 
      home: const WelcomePage(),
    );
  }
}
