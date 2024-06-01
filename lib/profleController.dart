import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileController {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  late User? user;
  late DocumentReference userDoc;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();

  final Map<String, bool> _editableFields = {};

  ProfileController({required this.auth, required this.db}) {
    user = auth.currentUser;
    userDoc = db.collection('users').doc(user?.uid);
  }

  Future<void> fetchUserData() async {
    if (user == null) return;
    DocumentSnapshot doc = await userDoc.get();
    if (!doc.exists) {
      // If the document doesn't exist, create it with default values
      await userDoc.set({
        'fullName': '',
        'email': user!.email ?? '',
        'gender': '',
        'mobilePhone': '',
        'dob': '',
        'age': '',
        'maritalStatus': '',
        'height': '',
        'weight': '',
        'nationality': '',
        'country': '',
        'city': '',
        'state': '',
        'address1': '',
        'address2': '',
        'zip': '',
      });
      doc = await userDoc.get();
    }
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    fullNameController.text = data['fullName'] ?? '';
    emailController.text = data['email'] ?? '';
    genderController.text = data['gender'] ?? '';
    mobilePhoneController.text = data['mobilePhone'] ?? '';
    dobController.text = data['dob'] ?? '';
    ageController.text = data['age'] ?? '';
    maritalStatusController.text = data['maritalStatus'] ?? '';
    heightController.text = data['height'] ?? '';
    weightController.text = data['weight'] ?? '';
    nationalityController.text = data['nationality'] ?? '';
    countryController.text = data['country'] ?? '';
    cityController.text = data['city'] ?? '';
    stateController.text = data['state'] ?? '';
    address1Controller.text = data['address1'] ?? '';
    address2Controller.text = data['address2'] ?? '';
    zipController.text = data['zip'] ?? '';
  }

  bool isFieldEditable(String field) {
    return _editableFields[field] ?? true;
  }

  void toggleFieldEditable(String field) {
    _editableFields[field] = !(isFieldEditable(field));
  }

  Future<String?> updateField(BuildContext context, String field) async {
    if (user == null) return 'No user is logged in';
    try {
      await userDoc.update({field: _getControllerForField(field).text});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  TextEditingController _getControllerForField(String field) {
    switch (field) {
      case 'fullName':
        return fullNameController;
      case 'email':
        return emailController;
      case 'gender':
        return genderController;
      case 'mobilePhone':
        return mobilePhoneController;
      case 'dob':
        return dobController;
      case 'age':
        return ageController;
      case 'maritalStatus':
        return maritalStatusController;
      case 'height':
        return heightController;
      case 'weight':
        return weightController;
      case 'nationality':
        return nationalityController;
      case 'country':
        return countryController;
      case 'city':
        return cityController;
      case 'state':
        return stateController;
      case 'address1':
        return address1Controller;
      case 'address2':
        return address2Controller;
      case 'zip':
        return zipController;
      default:
        throw ArgumentError('Invalid field name');
    }
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    mobilePhoneController.dispose();
    dobController.dispose();
    ageController.dispose();
    maritalStatusController.dispose();
    heightController.dispose();
    weightController.dispose();
    nationalityController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    zipController.dispose();
  }
}
