import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquor_locate2/Functions/init_new_user_data.dart';

class LoginSignupView extends StatefulWidget {
  const LoginSignupView({super.key});

  @override
  State<LoginSignupView> createState() => _LoginSignupView();
}

class _LoginSignupView extends State<LoginSignupView> {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerUsernameController =
      TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  final TextEditingController registerConfirmPasswordController =
      TextEditingController();
  final TextEditingController registerFirstNameController =
      TextEditingController();
  final TextEditingController registerLastNameController =
      TextEditingController();

  final TextEditingController resetPasswordController = TextEditingController();

  bool signInScreen = true;
  bool registerScreen = false;
  bool forgottenPasswordScreen = false;

  bool _signInValidate = false;
  String signInErrorText = "";

  bool _registerValidate = false;
  String registerErrorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          // Sign In Screen

          if (signInScreen)
            Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      const Text("Dont have an account?"),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 71, 124, 73)
                                    .withOpacity(0.2))),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 124, 73)),
                        ),
                        onPressed: () async {
                          setState(() {
                            signInScreen = false;
                            registerScreen = true;
                          });
                        },
                      )
                    ],
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: loginEmailController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    obscureText: true,
                    controller: loginPasswordController,
                    decoration: InputDecoration(
                      errorText: _signInValidate ? signInErrorText : null,
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 71, 124, 73)
                                    .withOpacity(0.2))),
                        child: const Text(
                          "Forgotten Password?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 124, 73)),
                        ),
                        onPressed: () async {
                          setState(() {
                            signInScreen = false;
                            forgottenPasswordScreen = true;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: OutlinedButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: loginEmailController.text,
                                      password: loginPasswordController.text);
                              await Future.delayed(
                                  const Duration(seconds: 1), () {});
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                if (e.code == "INVALID_LOGIN_CREDENTIALS") {
                                  signInErrorText =
                                      "You have entered an invalid email or password";
                                  _signInValidate = true;
                                } else {
                                  signInErrorText = e.code;
                                  _signInValidate = true;
                                }
                              });
                            }
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 124, 73)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Register Screen

          if (registerScreen)
            Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Register",
                    style: TextStyle(fontSize: 24),
                  ),
                  Row(
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 71, 124, 73)
                                    .withOpacity(0.2))),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 124, 73)),
                        ),
                        onPressed: () async {
                          setState(() {
                            registerScreen = false;
                            signInScreen = true;
                          });
                        },
                      )
                    ],
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: registerEmailController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: registerUsernameController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: registerFirstNameController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: registerLastNameController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    obscureText: true,
                    controller: registerPasswordController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    obscureText: true,
                    controller: registerConfirmPasswordController,
                    decoration: InputDecoration(
                      errorText: _registerValidate ? registerErrorText : null,
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: const UnderlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (registerUsernameController.text.length < 5 ||
                                registerUsernameController.text.length > 12) {
                              setState(() {
                                registerErrorText =
                                    "Username must be between 5 and 12 characters";
                                _registerValidate = true;
                              });
                            } else if (registerFirstNameController
                                    .text.isEmpty ||
                                registerFirstNameController.text.length > 15) {
                              setState(() {
                                registerErrorText =
                                    "First name must be between 1 and 15 characters";
                                _registerValidate = true;
                              });
                            } else if (registerLastNameController
                                    .text.isEmpty ||
                                registerLastNameController.text.length > 15) {
                              setState(() {
                                registerErrorText =
                                    "Last name must be between 1 and 15 characters";
                                _registerValidate = true;
                              });
                            } else if (registerPasswordController.text.length <
                                    5 ||
                                registerPasswordController.text.length > 15) {
                              setState(() {
                                registerErrorText =
                                    "Password must be between 5 and 15 characters";
                                _registerValidate = true;
                              });
                            } else if (registerPasswordController.text !=
                                registerConfirmPasswordController.text) {
                              setState(() {
                                registerErrorText =
                                    "Password and confirm password are not the same";
                                _registerValidate = true;
                              });
                            } else {
                              try {
                                var credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: registerEmailController.text,
                                  password: registerPasswordController.text,
                                );
                                await initNewUserData(
                                    credential.user!.uid,
                                    registerUsernameController.text,
                                    registerFirstNameController.text,
                                    registerLastNameController.text);
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  registerErrorText = e.code;
                                  _registerValidate = true;
                                });
                              }
                            }
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 124, 73)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          // Forgotten Password Screen

          if (forgottenPasswordScreen)
            Container(
              padding: const EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Forgotten Password",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    children: [
                      Text(
                        "Provide your email and we will send you a link to reset your password",
                        maxLines: 2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: resetPasswordController,
                    decoration: const InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Color.fromARGB(255, 71, 124, 73),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color.fromARGB(255, 71, 124, 73),
                      )),
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 71, 124, 73)
                                    .withOpacity(0.2))),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 124, 73)),
                        ),
                        onPressed: () async {
                          setState(() {
                            forgottenPasswordScreen = false;
                            signInScreen = true;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: OutlinedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: resetPasswordController.text);
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Forgotten Password"),
                                  content: const Text("An email has been sent to your email address to reset your password."),
                                  actions: [
                                    TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color.fromARGB(255, 114, 114, 114))),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Reset Password",
                            style: TextStyle(
                                color: Color.fromARGB(255, 71, 124, 73)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      )
    );
  }
}
