import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase?.initializeApp();
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
