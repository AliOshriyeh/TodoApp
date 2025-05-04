import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task01/domain/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.signOut(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${authController.user?.email ?? ''}'),
            SizedBox(height: 20),
            Text('You are logged in!'),
          ],
        ),
      ),
    );
  }
}
