import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello/src/recent_activity_page.dart';
import 'package:hello/src/dashboard_page.dart';
import 'package:hello/src/edit_profile_page.dart';
import 'package:hello/src/mappage.dart';
import 'package:hello/src/welcome_page.dart';
import 'package:hello/src/bus_provider.dart';
import 'package:hello/src/theme_provider.dart';
import 'package:hello/src/landing_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Campus-Jatra',
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const LandingPage(),
            routes: {
              '/welcome': (context) => WelcomePage(userName: 'User'),
              '/dashboard': (context) => const DashboardPage(),
              '/edit-profile': (context) => EditProfilePage(),
              '/map': (context) => const MapPage(),
              '/recent-activity': (context) => const RecentActivityPage(),
            },
          );
        },
      ),
    );
  }
}