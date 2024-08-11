import 'package:flutter/material.dart';
import 'package:stadia_scanner/scan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? id;
  String? pass;
  bool rememberMe = false;


  static const String univId = 'q';
  static const String univPass = 'q';

  final idController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  @override
  void dispose() {
    idController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        idController.text = prefs.getString('id') ?? '';
        passController.text = prefs.getString('pass') ?? '';
      }
    });
  }


  Future<void> _saveUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('id', idController.text);
      await prefs.setString('pass', passController.text);
    } else {
      await prefs.remove('id');
      await prefs.remove('pass');
    }
    await prefs.setBool('rememberMe', rememberMe);
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
      await _saveUserCredentials();
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
