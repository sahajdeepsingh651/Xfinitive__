import 'package:flutter/material.dart';

class About_Screen extends StatelessWidget {
  const About_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About us")),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(45),
              child: CircleAvatar(
                  radius: 150, child: Image.asset('assets/images/Logo.png'))),
          SizedBox(
            height: 40,
          ),
          Text(
            "Xfinitive",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "Smart Healthcare for all",
            style: TextStyle(fontSize: 24),
          ),
          Text("Version: 1.0.0", style: TextStyle(fontSize: 24))
        ],
      ),
    );
  }
}
