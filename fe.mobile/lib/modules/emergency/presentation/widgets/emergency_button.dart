import 'package:flutter/material.dart';
import 'package:mobile/modules/emergency/presentation/pages/emergency_page.dart';

class EmergencyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add_moderator),
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmergencyPage()));
        });
  }
}
