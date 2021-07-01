import 'package:flutter/material.dart';
import 'package:mobile/modules/user/presentation/pages/home_page.dart';
import 'package:mobile/widgets/main_app_bar.dart';
import 'package:mobile/widgets/main_drawer.dart';
import 'package:mobile/widgets/main_navigation_bar.dart';
import 'package:mobile/modules/emergency/presentation/widgets/emergency_button.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: HomePage(),
      drawer: MainDrawer(),
      floatingActionButton: EmergencyButton(),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}