import 'package:flutter/material.dart';
import 'database/database.dart';
import 'home.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabase mongoDb = MongoDatabase();
  await mongoDb.connect();
  User user1 = User(
    name: 'Henry IKF',
    regId: '127',
    entryTime: '09:00',
    exitTime: '19:00',
    isCheckedIn: 'true',
    isCheckedOut: 'false',
  );
  //await mongoDb.insert(user1);
  //print('User 1 added successfully');
  MongoDatabase.update(
      regId: '123',
      isInEntryMode: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelStyle: const TextStyle(color: Colors.white54),
          floatingLabelStyle: const TextStyle(color: Colors.deepPurpleAccent),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(160, 56)),
            iconSize: MaterialStateProperty.all(24),
            textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 24)),
            elevation: MaterialStateProperty.all(8),
            backgroundColor: MaterialStateProperty.all(Colors.black),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        brightness: Brightness.light,
      ),
      //TODO: Change Email and pass
      //TODO: Remove DebugPrints
      //TODO: Separate sensitive info
      //TODO: Setup write/fetch guard
      //TODO: Enable Database 
      home: const HomePage(),
    );
  }
}
