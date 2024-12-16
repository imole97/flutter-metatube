import 'package:flutter/material.dart';
import 'package:metatube/screens/home_screen.dart';
import 'package:metatube/screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(400, 700),
      size: Size(600, 780),
      center: true,
      title: 'MetaTube');
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, // to remove the red debug banner
        home: SplashScreen()
        // home:HomeScreen()
        );
  }
}
