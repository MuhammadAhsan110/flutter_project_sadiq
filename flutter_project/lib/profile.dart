import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/profile_pic');
              },
              child: const Text('Profile Pic'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Home Page'),
            )
          ],
        ),
      ),
    );
  }
}
