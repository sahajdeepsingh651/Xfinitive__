import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xfinitive/Screens/onboardingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xfinitive/firebase_options.dart';

import 'package:xfinitive/reminder/global_bloc.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xfinitive/Screens/welcomescreen.dart';


import 'package:xfinitive/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  ); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalBloc>(
          create: (_) => GlobalBloc(),
        ),
        // Add other providers if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Removed debug banner
        title: 'Splash Screen Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: textTheme,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
    _checkOnboardingStatus();
  }

  void _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    // Navigate after the splash screen
    Future.delayed(Duration(seconds: 3), () {
      if (onboardingComplete) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF33E4DB), // Top color
              Color(0xFF432C81), // Bottom color
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Logo.png', // Replace with your image path
                width: 392,
                height: 273,
              ),
              Image.asset(
                'assets/images/name.png', // Replace with your image path
                width: 308,
                height: 64,
              ),
              SizedBox(height: 20),
              Text(
                'Smart Healthcare for all',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
