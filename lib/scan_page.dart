import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stadia_scanner/scanning_page.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 100,left: 15,right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/logo.jpg',
                height: 34,
                width: double.infinity,
              ),

              Column(children: [ SvgPicture.asset(
                'assets/ticket-entry.svg',
                height: 180,
                width: double.infinity,
              ),const Text(
                'Entry Tickets',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 28,
                    fontWeight: FontWeight.w900),
              ),],),



              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScanningPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.document_scanner_outlined),
                label: const Text('Scan Tickets'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
