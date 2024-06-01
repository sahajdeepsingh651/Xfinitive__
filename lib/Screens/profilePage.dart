import 'package:flutter/material.dart';
import 'package:xfinitive/profleController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController profileController;
  File? _image;

  final Map<String, FocusNode> _focusNodes = {};

  @override
  void initState() {
    super.initState();
    profileController = ProfileController(
      auth: FirebaseAuth.instance,
      db: FirebaseFirestore.instance,
    );
    profileController.fetchUserData();

    // Initialize FocusNodes for each field
    _initializeFocusNodes();
  }

  void _initializeFocusNodes() {
    List<String> fields = [
      "fullName",
      "email",
      "gender",
      "mobilePhone",
      "dob",
      "age",
      "maritalStatus",
      "height",
      "weight",
      "nationality",
      "country",
      "city",
      "state",
      "address1",
      "address2",
      "zip"
    ];
    for (var field in fields) {
      _focusNodes[field] = FocusNode();
    }
  }

  @override
  void dispose() {
    profileController.dispose();
    // Dispose all FocusNodes
    _focusNodes.forEach((key, focusNode) => focusNode.dispose());
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      // Upload the image to Firestore or Firebase Storage
      // And update the user's profile with the new image URL
    }
  }

  Future<void> _updateAllFields() async {
    List<String> fields = [
      "fullName",
      "email",
      "gender",
      "mobilePhone",
      "dob",
      "age",
      "maritalStatus",
      "height",
      "weight",
      "nationality",
      "country",
      "city",
      "state",
      "address1",
      "address2",
      "zip"
    ];

    // Display the "Please wait" SnackBar
    final pleaseWaitSnackBar = SnackBar(
      content: Text('Please wait...'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(pleaseWaitSnackBar);

    for (String field in fields) {
      String? error = await profileController.updateField(context, field);
      if (error != null) {
        // Hide the "Please wait" SnackBar
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    // Hide the "Please wait" SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All fields updated successfully'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      // Update all fields to non-editable after successful update
      fields.forEach((field) => profileController.toggleFieldEditable(field));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text("Profile",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(height: 50),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        AssetImage('assets/images/Lifesavers Avatar.png'),
                    // backgroundImage: _image != null
                    //   ? FileImage(_image!)
                    //   : AssetImage('assets/images/Lifesavers Avatar.png') as ImageProvider,
                    // child: _image == null
                    //   ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                    //   : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoField("Full Name", profileController.fullNameController,
                  Icons.person, "fullName"),
              _buildInfoField("Email", profileController.emailController,
                  Icons.alternate_email_rounded, "email"),
              _buildInfoField("Gender", profileController.genderController,
                  Icons.transgender, "gender"),
              _buildInfoField(
                  "Mobile Phone",
                  profileController.mobilePhoneController,
                  Icons.phone,
                  "mobilePhone"),
              _buildInfoField("Date of Birth", profileController.dobController,
                  Icons.cake, "dob"),
              _buildInfoField("Age", profileController.ageController,
                  Icons.hourglass_empty, "age"),
              _buildInfoField(
                  "Marital Status",
                  profileController.maritalStatusController,
                  Icons.favorite,
                  "maritalStatus"),
              _buildInfoField("Height (cm)", profileController.heightController,
                  Icons.height, "height"),
              _buildInfoField("Weight (kg)", profileController.weightController,
                  Icons.fitness_center, "weight"),
              _buildInfoField(
                  "Nationality",
                  profileController.nationalityController,
                  Icons.flag,
                  "nationality"),
              _buildInfoField("Country", profileController.countryController,
                  Icons.public, "country"),
              _buildInfoField("City", profileController.cityController,
                  Icons.location_city, "city"),
              _buildInfoField("State", profileController.stateController,
                  Icons.landscape, "state"),
              _buildInfoField("Address 1", profileController.address1Controller,
                  Icons.home, "address1"),
              _buildInfoField("Address 2", profileController.address2Controller,
                  Icons.home_work, "address2"),
              _buildInfoField("ZIP Code", profileController.zipController,
                  Icons.local_post_office, "zip"),
              SizedBox(height: 20),
              Divider(thickness: 1.5),
              ElevatedButton(
                onPressed: _updateAllFields,
                child: Text('Update All Fields'),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, TextEditingController controller,
      IconData icon, String field) {
    bool isEditable = profileController.isFieldEditable(field);
    FocusNode focusNode = _focusNodes[field]!;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(icon),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!isEditable) {
                  profileController.toggleFieldEditable(field);
                  setState(() {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(focusNode);
                  });
                }
              },
              child: TextFormField(
                controller: controller,
                enabled: isEditable,
                focusNode: focusNode,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.0,
                ),
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: label,
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (isEditable) {
                String? error =
                    await profileController.updateField(context, field);
                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  FocusScope.of(context).unfocus();
                }
              } else {
                profileController.toggleFieldEditable(field);
                setState(() {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(focusNode);
                });
              }
              setState(() {});
            },
            icon: Icon(isEditable ? Icons.edit : Icons.check),
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
