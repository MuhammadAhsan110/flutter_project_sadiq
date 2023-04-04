import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Log extends StatelessWidget {
  const Log({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: 'dashboard_pressed',
                );
                // ignore: use_build_context_synchronously
                context.go('/dashboard');
              },
              child: const Text('Dashboard'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: 'button_pressed',
                );
                // ignore: use_build_context_synchronously
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
