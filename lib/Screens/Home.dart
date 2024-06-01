import 'package:flutter/material.dart';

import 'package:xfinitive/Screens/profilePage.dart';
import 'package:xfinitive/Screens/welcomescreen.dart';
import 'package:xfinitive/Screens/my_deviceforhome.dart';
import 'package:xfinitive/Myfamily/Myfamily.dart';
import 'package:xfinitive/Mydoctor/Mydoctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xfinitive/reminder/medicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreendart extends StatefulWidget {
  final String? name;

  HomeScreendart({this.name});

  @override
  State<HomeScreendart> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreendart> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   title: Text('Settings',style: Theme.of(context).textTheme.titleLarge,),
      // ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.24,
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        'Welcome to Xfinitive',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (widget.name != null)
                      Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              children: [
                                const Text(
                                  "Hi  ",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.name!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: TextButton(
                        onPressed: () async {
                          await _handleSignOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()),
                            (route) => false,
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(99, 251, 251, 251),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            title: Text('My Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            title: Text('My Family'),
            leading: Icon(Icons.family_restroom),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FamilyScreen()),
              );
            },
          ),
          ListTile(
            title: Text('My Doctors'),
            leading: Icon(Icons.medical_services),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorScreen__()),
              );
            },
          ),
          ListTile(
            title: Text('My Medication'),
            leading: FaIcon(
              FontAwesomeIcons.capsules,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReminderScreen()),
              );
            },
          ),
          ListTile(
            title: Text('My device'),
            leading: Icon(Icons.devices),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyDeviceScreenCopy()),
              );
            },
          ),
        ],
      ),
    );
  }

  void Navigation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
    _auth.signOut;
  }

  Future<void> _handleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } catch (error) {
      print(error);
    }
  }
}
