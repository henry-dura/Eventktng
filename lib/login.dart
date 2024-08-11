import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stadia_scanner/scan_page.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/login/login_event.dart';
import 'blocs/login/login_state.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load preferences'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No preferences found'));
        }

        final prefs = snapshot.data!;
        return BlocProvider(
          create: (context) => LoginBloc(prefs: prefs)..add(LoadUserCredentials()),
          child: const LoginForm(),
        );
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final idController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passController.dispose();
    super.dispose();
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
                              const Text('Username', style: TextStyle(color: Colors.white, fontSize: 16)),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginLoaded && idController.text.isEmpty) {
                                    idController.text = state.id;
                                  }
                                  return TextField(
                                    controller: idController,
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Password', style: TextStyle(color: Colors.white, fontSize: 16)),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  if (state is LoginLoaded && passController.text.isEmpty) {
                                    passController.text = state.pass;
                                  }
                                  return TextField(
                                    controller: passController,
                                    obscureText: state is LoginLoaded ? state.obscureText : true,
                                    onChanged: (value) {
                                      context.read<LoginBloc>().add(PasswordChanged(value));
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: state is LoginLoaded && passController.text.isNotEmpty
                                          ? IconButton(
                                        icon: Icon(state.obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          context.read<LoginBloc>().add(ToggleObscureText());
                                        },
                                      )
                                          : null,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  bool rememberMe = false;
                                  if (state is LoginLoaded) {
                                    rememberMe = state.rememberMe;
                                  }

                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: rememberMe,
                                        side: MaterialStateBorderSide.resolveWith(
                                              (states) => const BorderSide(width: 1.0, color: Colors.white),
                                        ),
                                        onChanged: (bool? value) {
                                          context.read<LoginBloc>().add(RememberMeChanged(value ?? false));
                                        },
                                      ),
                                      const Text("Remember Me", style: TextStyle(color: Color(0xFFFFFFFF))),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF111111)),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 18)),
                        ),
                        onPressed: () {
                          final id = idController.text.trim();
                          final pass = passController.text.trim();
                          context.read<LoginBloc>().add(LoginButtonPressed(id: id, pass: pass));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginFailure) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  "Oops!",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text("Looks like there is a problem with Username or password... \nRecheck the details you have entered."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is LoginSuccess) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ScanPage()));
                          }
                        },
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
