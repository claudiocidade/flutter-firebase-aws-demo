import 'package:flutter/material.dart';
import 'package:mobile/modules/emergency/presentation/widgets/emergency_button.dart';
import 'package:mobile/widgets/main_app_bar.dart';
import 'package:mobile/widgets/main_navigation_bar.dart';
import 'package:mobile/widgets/main_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Container(),
      drawer: MainDrawer(),
      floatingActionButton: EmergencyButton(),
      bottomNavigationBar: MainNavigationBar(),
    );
  }
}
