import 'package:flutter/material.dart';

class MyDeviceScreenCopy extends StatefulWidget {
  const MyDeviceScreenCopy({super.key});

  @override
  State<MyDeviceScreenCopy> createState() => _MyDeviceScreenState();
}

class _MyDeviceScreenState extends State<MyDeviceScreenCopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset(
                'assets/images/Cool Kids Sitting.png',
                height: 350.0,
                width: 350.0,
                // You may need to adjust the size
              ),
              SizedBox(height: 60.0),
      // Add a sized box
              ElevatedButton(
                onPressed: () {},
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
                  'My readings',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
              ),
              SizedBox(height: 20.0), // Add a tiny sized box
      
              TextButton(
                onPressed: () {},
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
                  'Pair device',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
