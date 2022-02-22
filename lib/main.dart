import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Vista App Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    showBadge: true,
    enableLights: true,
    enableVibration: true,
    ledColor: const Color(0xffD6BA5E),
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        title: 'Vista App',
        routes: appRoutes,
        initialRoute: 'loading',
        theme: ThemeData(
          // brightness: Brightness.light,
          primaryColor: const Color(0xff211915),
          colorScheme: theme.colorScheme.copyWith(
              primary: const Color(0xffD6BA5E),
              secondary: const Color(0xffD6BA5E)),
          appBarTheme: const AppBarTheme(
              color: Color(0xff1B1B1B), centerTitle: true, elevation: 1.5),
        ),
      ),
    );
  }
}
