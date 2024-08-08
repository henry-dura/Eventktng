import 'package:flutter/material.dart';
import 'package:stadia_scanner/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width/10),
        child: Center(
          child: SizedBox(
            height: size.height/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('IMAGE'),
                const Column(
                  children: [
                    Text('Scan and validate ',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w900),),
                    Text('your event tickets',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w900)),
                    Text('powered by', style: TextStyle(fontSize: 17),),
                    Text('Senior Barman Entertainment Ltd',style: TextStyle(fontSize: 17),)
                  ],
                ),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }, child: const Text('Get Started'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
