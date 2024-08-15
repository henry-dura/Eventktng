import 'package:flutter/material.dart';
import 'package:stadia_scanner/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width/10),
          child: Center(
            child: SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logo.jpg',height: 52,),
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
      ),
    );
  }
}
