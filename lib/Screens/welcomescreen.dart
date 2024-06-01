import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xfinitive/Screens/NavigationScreen.dart';
import 'package:xfinitive/Screens/signupScreen.dart';
import 'package:xfinitive/Screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(fontSize: 40),
          textAlign: TextAlign.left,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 65),
              Image.asset(
                'assets/images/Lifesavers Bust.png',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02),
                ),
              ),
              SizedBox(height: 20,child: Text("OR"),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.074,
                width: MediaQuery.of(context).size.height * 0.34,
                child: SignInButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  Buttons.google,
                  text: "Sign in with Google",
                  onPressed: _handleGoogleSignIn,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
            height: MediaQuery.of(context).size.height * 0.074,
                width: MediaQuery.of(context).size.height * 0.34,

                child: SignInButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  Buttons.facebook,
                  text: "Sign in with Facebook",
                  onPressed: _handleFacebookSignIn,
                ),
              ),
                         SizedBox(height: 20),   SizedBox(
            height: MediaQuery.of(context).size.height * 0.074,
                width: MediaQuery.of(context).size.height * 0.34,
                
                child: SignInButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.black),
                  ),
                  Buttons.apple,
                  text: "Sign in with Apple",
                  onPressed:(){},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      String displayName = googleUser.displayName ?? '';
      if (displayName.isEmpty) {
        final promptedName = await _promptForDisplayName();
        if (promptedName != null && promptedName.isNotEmpty) {
          displayName = promptedName;

          if (user != null) {
            await user.updateProfile(displayName: displayName);
            await user.reload();
            user = _auth.currentUser;
          }
        }
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(name: displayName)),
      );
    } catch (error) {
      print("Error during Google sign-in: $error");
    }
  }

  Future<void> _handleFacebookSignIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        String displayName = user?.displayName ?? '';
        if (displayName.isEmpty) {
          final promptedName = await _promptForDisplayName();
          if (promptedName != null && promptedName.isNotEmpty) {
            displayName = promptedName;

            if (user != null) {
              await user.updateProfile(displayName: displayName);
              await user.reload();
              user = _auth.currentUser;
            }
          }
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(name: displayName)),
        );
      } else if (result.status == LoginStatus.cancelled) {
        print("Facebook sign-in cancelled");
      } else {
        print("Facebook sign-in failed: ${result.message}");
      }
    } catch (error) {
      print("Error during Facebook sign-in: $error");
    }
  }

  Future<String?> _promptForDisplayName() async {
    String? displayName;
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Display Name'),
          content: TextField(
            onChanged: (value) {
              displayName = value;
            },
            decoration: InputDecoration(hintText: "Display Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(displayName);
              },
            ),
          ],
        );
      },
    );
    return displayName;
  }
}
