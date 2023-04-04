import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task2/dashboard.dart';
import 'package:flutter_task2/log.dart';
import 'package:flutter_task2/profile.dart';
import 'package:flutter_task2/search.dart';
import 'package:flutter_task2/userinfo.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,

      title: 'Sadiq',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //home: const MyHomePage(),
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(
        path: '/log',
        builder: (context, state) => const Log(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const Profile(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const Search(),
      ),
      GoRoute(
        path: '/location',
        builder: (context, state) => const UpdateLocationPage(),
      ),
      GoRoute(
        path: '/userinfo',
        builder: (context, state) => const UserInfo(),
      )
    ],
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/dashboard');
              },
              child: const Text('Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/log');
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}

// class UserInfo extends StatelessWidget {
//   const UserInfo({Key? key}) : super(key: key);

//   Future<String> getIPAddress() async {
//     final response = await http.get(Uri.parse('https://api.ipify.org'));

//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       throw Exception('Failed to get IP address');
//     }
//   }

//   Widget showCard(String name, String value) {
//     return Card(
//       child: ListTile(
//         title: Text(
//           "$name : $value",
//           style: const TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: FutureBuilder<AndroidDeviceInfo>(
//       future: DeviceInfoPlugin().androidInfo,
//       builder: (context, snapshot) {
//         final data = snapshot.data;
//         if (data == null) return const SizedBox();

//         return Column(children: [
//           showCard('brand', data.brand!),
//           showCard('device', data.device!),
//           showCard('model', data.model!),
//           showCard('manufacturer', data.manufacturer!),
//           showCard('product', data.product!),
//           showCard('hardware', data.hardware!),
//           showCard('isPhysicalDevice', data.isPhysicalDevice.toString()),
//           showCard('version', data.version.release.toString()),
//           FutureBuilder<String>(
//             future: getIPAddress(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return showCard('IP address', snapshot.data!);
//               } else if (snapshot.hasError) {
//                 return const Text('Failed to get IP address');
//               } else {
//                 return const SizedBox();
//               }
//             },
//           ),
//         ]);
//       },
//     )));
//   }
// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
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
                  name: 'log_pressed',
                );
                // ignore: use_build_context_synchronously
                context.go('/log');
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            IconButton(
              icon: const Icon(Icons.location_on, color: Colors.blue),
              onPressed: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: 'location_pressed',
                );
                // ignore: use_build_context_synchronously
                context.go('/location');
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/userinfo');
              },
              child: const Text('User Info'),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Search()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                  settings: const RouteSettings(name: 'Profile'),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
