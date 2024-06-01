// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:xfinitive/Screens/helpScreen.dart';

import 'package:xfinitive/Screens/termsofuse.dart';
import 'package:xfinitive/Screens/privacypolicy.dart';
import 'package:xfinitive/Screens/about.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class User {
  String? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? gender;
  DateTime? dateOfBirth;
  String? maritalStatus;
  double? height;
  double? weight;
  String? nationality;
  String? country;
  String? city;
  String? state;
  String? address1;
  String? address2;
  String? zipCode;

  User({
    this.id,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.gender,
    this.dateOfBirth,
    this.maritalStatus,
    this.height,
    this.weight,
    this.nationality,
    this.country,
    this.city,
    this.state,
    this.address1,
    this.address2,
    this.zipCode,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'mobileNumber': mobileNumber,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
        'maritalStatus': maritalStatus,
        'height': height,
        'weight': weight,
        'nationality': nationality,
        'country': country,
        'city': city,
        'state': state,
        'address1': address1,
        'address2': address2,
        'zipCode': zipCode,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        fullName: json['fullName'],
        email: json['email'],
        mobileNumber: json['mobileNumber'],
        gender: json['gender'],
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth'])
            : null,
        maritalStatus: json['maritalStatus'],
        height: json['height']?.toDouble(),
        weight: json['weight']?.toDouble(),
        nationality: json['nationality'],
        country: json['country'],
        city: json['city'],
        state: json['state'],
        address1: json['address1'],
        address2: json['address2'],
        zipCode: json['zipCode'],
      );
}

class SettingsScreen extends StatefulWidget {
  final String? fullName;

  final String? email;
  const SettingsScreen({Key? key, this.fullName, this.email}) : super(key: key);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 
  late String _email;

  @override
  void initState() {
    super.initState();
    
    _email = widget.email ?? '';
  }

  Future<User?> getUserData(String userId) async {
  
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {

      return User.fromJson(userDoc.data()!);
    }
   

    return null;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        
      //   title: Text('Settings',style: Theme.of(context).textTheme.titleLarge,),
      // ),
      body: ListView(
        children: [
          UserAccountsDrawerHeader(
            margin: EdgeInsets.only(top:50),
            accountName: Text("Settings",style: TextStyle(fontSize: 24),),
            accountEmail: Text(_email),
            currentAccountPicture: CircleAvatar( backgroundImage: AssetImage('assets/images/material-symbols_settings-outline.png'),

            ),
          ),
          ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Terms Of Use'),
            leading: Icon(Icons.family_restroom),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Termsofuse()),
              );
            },
          ),

       
  
          ListTile(
            title: Text('Help'),
            leading: Icon(Icons.devices),
                        onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Helpscreen()),
              );
            },
          ),
          ListTile(
            title: Text('About'),
            leading: Icon(Icons.medical_services),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About_Screen()),
              );
            },
          ),
        ],
      ),
    );
  }
}


