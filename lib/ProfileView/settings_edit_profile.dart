/*

View that shows the settings to edit a user's profile

*/

//External Files
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';

//External Packages
import 'package:flutter/material.dart';

class SettingsEditProfileView extends StatefulWidget {
  const SettingsEditProfileView(
      {super.key,
      required this.userId,
      required this.selectedProfilePicImage,
      required this.firstName,
      required this.lastName});
  final String userId;
  final AssetImage selectedProfilePicImage;
  final String firstName;
  final String lastName;

  @override
  State<StatefulWidget> createState() {
    return _SettingsEditProfileView();
  }
}

class _SettingsEditProfileView extends State<SettingsEditProfileView> {
  late String userId;

  late AssetImage selectedProfilePicImage;

  late String firstName;
  late String lastName;

  List<String> profilePicImageStrings = [
    "lib/assets/TequilaImages/Patron.png",
    "lib/assets/BeerImages/coors.png",
    "lib/assets/WineImages/Apothic.png",
    "lib/assets/WhiskeyImages/fireball.png",
  ];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    selectedProfilePicImage = widget.selectedProfilePicImage;
    firstName = widget.firstName;
    lastName = widget.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3,
          backgroundColor: const Color.fromARGB(255, 236, 87, 95),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Pic Selector
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, bottom: 5),
              child: const Text(
                "Profile Picture",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 112, 112, 112)),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(image: selectedProfilePicImage),
                      ),
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (var imageString in profilePicImageStrings)
                        Column(
                          children: [
                            if (AssetImage(imageString) ==
                                selectedProfilePicImage)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red, width: 3),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.all(2),
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child:
                                          Image(image: AssetImage(imageString)),
                                    )),
                              ),
                            if (AssetImage(imageString) !=
                                selectedProfilePicImage)
                              InkWell(
                                borderRadius: BorderRadius.circular(150),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image(
                                            image: AssetImage(imageString)),
                                      )),
                                ),
                                onTap: () async {
                                  setState(() {
                                    selectedProfilePicImage =
                                        AssetImage(imageString);
                                  });
                                  var db = FirebaseFirestore.instance;

                                  await db
                                      .collection("users")
                                      .doc(userId)
                                      .update({"profilePic": imageString});
                                },
                              ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),

            // Edit First Name

            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, bottom: 15),
              child: const Text(
                "Full Name",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(30),
                        color: SchedulerBinding.instance.platformDispatcher
                                    .platformBrightness ==
                                Brightness.dark
                            ? const Color.fromARGB(255, 61, 61, 61)
                            : Colors.white,
                        boxShadow: [
                          if (SchedulerBinding.instance.platformDispatcher
                                  .platformBrightness ==
                              Brightness.light)
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                        ],
                      ),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      width: (MediaQuery.of(context).size.width - 40),
                      height: 50,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 11),
                            hintText: firstName,
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),

                // Edit Last Name

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      width: (MediaQuery.of(context).size.width - 40),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3),
                        borderRadius: BorderRadius.circular(30),
                        color: SchedulerBinding.instance.platformDispatcher
                                    .platformBrightness ==
                                Brightness.dark
                            ? const Color.fromARGB(255, 61, 61, 61)
                            : Colors.white,
                        boxShadow: [
                          if (SchedulerBinding.instance.platformDispatcher
                                  .platformBrightness ==
                              Brightness.light)
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                        ],
                      ),
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 11),
                            hintText: lastName,
                            hintStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red)),
                      onPressed: () async {
                        if (firstNameController.text != "") {
                          var db = FirebaseFirestore.instance;

                          await db
                              .collection("users")
                              .doc(userId)
                              .update({"firstName": firstNameController.text});
                        }
                        if (lastNameController.text != "") {
                          var db = FirebaseFirestore.instance;

                          await db
                              .collection("users")
                              .doc(userId)
                              .update({"lastName": lastNameController.text});

                          var db2 = FirebaseFirestore.instance;

                          await db2.collection("users").doc(userId).update(
                              {"lastNameInitial": lastNameController.text[0]});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )
          ],
        )));
  }
}
