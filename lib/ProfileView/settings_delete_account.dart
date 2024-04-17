/*

View displaying the delete account settings

NOT FINISHED

*/

//Internal Files
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquor_locate2/Functions//delete_user_data.dart';


//External Packages
import 'package:flutter/material.dart';

class SettingsDeleteAccountView extends StatefulWidget {
  const SettingsDeleteAccountView({super.key, required this.username, required this.userId});

  final String userId;
  final String username;

  @override
  State<SettingsDeleteAccountView> createState() =>
      _SettingsDeleteAccountView();
}

class _SettingsDeleteAccountView extends State<SettingsDeleteAccountView> {
  late String username;
  late String userId;
  final TextEditingController controller = TextEditingController();

  String errorMessage = "error";
  bool errorBool = false;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Delete Account",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 236, 87, 95),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Are you sure you want to delete your account?",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "All user data will be lost, if you'd still like to delete your account type your username below and select delete."),
              const SizedBox(height: 15),
              TextField(
                cursorColor: Colors.grey,
                controller: controller,
                decoration: InputDecoration(
                  errorText: errorBool ? errorMessage : null,
                  floatingLabelStyle: const TextStyle(
                    color: Color.fromARGB(255, 71, 124, 73),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 71, 124, 73),
                  )),
                  border: const OutlineInputBorder(),
                  labelText: username,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (username != controller.text) {
                          setState(() {
                            errorMessage = "Incorrect Username";
                            errorBool = true;
                          });
                        } else {
                          try {
                            await FirebaseAuth.instance.currentUser!.delete();
                            await deleteUserData(userId);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "requires-recent-login") {
                              setState(() {
                                errorMessage =
                                  "In order to delete your account you must sign out and sign back in";
                              errorBool = true;
                              });
                            
                            } else {
                              setState(() {
                                errorMessage = e.code;
                              errorBool = true;
                              });
                            }
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
                        "Delete",
                        style:
                            TextStyle(color: Color.fromARGB(255, 190, 46, 46)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
