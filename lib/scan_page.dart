import 'package:flutter/material.dart';
import 'package:stadia_scanner/entry_and_exit.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 34,
              width: double.infinity,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Entry Tickets',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 28,
                  fontWeight: FontWeight.w900),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EntryAndExitPage(),
                    ),
                  );
                },
                child: const Text('Scan Ticket'))
          ],
        ),
      ),
    );
  }
}
