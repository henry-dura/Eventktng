import 'package:flutter/material.dart';
import 'package:stadia_scanner/scan_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? id;
  String? pass;
  bool rememberMe = false;


  // static const String univId = 'foundanand';
  // static const String univPass = '@Strae#@cet3';
  static const String univId = 'q';
  static const String univPass = 'q';

  final idController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passController.dispose();
    super.dispose();
  }


  Future<void> _validator(BuildContext context) async {
    var id = idController.text.trim();
    var pass = passController.text.trim();

    if (id == '' || pass == '' || pass != univPass || id != univId) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Oops!",
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
              "Looks like there is problem in Username or password... \nRecheck the details you have entered."),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"))
          ],
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScanPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFFF6600),

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 10,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0XFF333333),
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      Column(

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Username',style: TextStyle(color: Colors.white,fontSize: 16)),
                              TextField(
                                controller: idController,

                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Password',style: TextStyle(color: Colors.white,fontSize: 16)),
                              TextField(
                                controller: passController,
                                obscureText: true,
                                // decoration:
                                //     const InputDecoration(labelText: "Password"),
                                // style: const TextStyle(color: Colors.white),
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    value: rememberMe,
                                    side: MaterialStateBorderSide.resolveWith(
                                          (states) => const BorderSide(width: 1.0, color: Colors.white),
                                    ),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text("Remember Me",style: TextStyle(color: Color(0xFFFFFFFF)),)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),


                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(const Color(0xFF111111)),
                            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 18)),
                          ),
                          onPressed: () {
                            _validator(context);

                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 22),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
