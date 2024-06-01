import 'package:flutter/material.dart';

import 'package:xfinitive/Screens/welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String continueText;
  final String skipText;
  final Function onNextPressed;
  final Function? onSkipPressed;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.continueText,
    this.skipText = 'Skip Tour',
    required this.onNextPressed,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:  MediaQuery.of(context).size.height * 0.1,),
            Image.asset(
              image,
              height: 350.0,
              width: 350.0,
              // You may need to adjust the size
            ),
            SizedBox(height: 20.0),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.0376,
                    color: Color.fromRGBO(67, 44, 129, 1),
                  ),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 30.0), // Add a sized box
            ElevatedButton(
              onPressed: onNextPressed as void Function()?,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.black), // Stroke color
                ),
              ),
              child: Text(
                continueText,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              ),
            ),
            SizedBox(height: 20.0), // Add a tiny sized box
            if (onSkipPressed != null)
              TextButton(
                onPressed: onSkipPressed != null ? () => onSkipPressed!() : null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black), // Stroke color
                  ),
                ),
                child: Text(
                  skipText,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPage(
        image: 'assets/images/Lifesavers Hand.png',
        title: 'Discover Top Doctors',
        description:
            'Explore elite medical expertise. Discover top doctors meticulously selected for you. Find trusted healthcare with ease.',
        continueText: 'Continue',
        skipText: 'Skip Tour',
        onNextPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen2()),
          );
        },
        onSkipPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboardingComplete', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        },
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPage(
        image: 'assets/images/Lifesavers Caretaking.png',
        title: 'Ask a Doctor Online',
        description:
            'Connect with experienced doctors anytime, anywhere. Get expert medical advice and answers to your questions.',
        continueText: 'Continue',
        skipText: 'Skip Tour',
        onNextPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen3()),
          );
        },
        onSkipPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboardingComplete', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        },
      ),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPage(
        image: 'assets/images/Lifesavers New Patient.png',
        title: 'Get Expert Advice',
        description:
            'Unlock access to expert advice at your fingertips. Connect with seasoned professionals for personalized guidance.',
        continueText: 'Continue',
        onNextPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('onboardingComplete', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        },
      ),
    );
  }
}
