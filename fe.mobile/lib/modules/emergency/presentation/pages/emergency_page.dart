import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child:
            Text("Emergency Mode: ON", style: TextStyle(fontSize: 24)),
          )
        ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.pop(context); },
        child: Icon(Icons.cancel)
      ),
    );
  }
}