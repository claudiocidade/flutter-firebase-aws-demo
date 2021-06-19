import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text("mobile"),
      actions: [
        IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
      ],
    );
  }
}
