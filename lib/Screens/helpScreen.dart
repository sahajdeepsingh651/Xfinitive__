import 'package:flutter/material.dart';

class Helpscreen extends StatelessWidget {
  const Helpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Help")),
    body: Container(child: Center(child: Text("need help?")),),

    );
  }
}