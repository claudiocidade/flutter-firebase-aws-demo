import 'package:flutter/material.dart';

class MainNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: BottomNavigationBar(
            currentIndex: 0,
            items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Share',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_moderator),
            label: 'Emergency',
          ),
        ]));
  }
}
