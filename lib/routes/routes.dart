import 'package:flutter/material.dart';
import 'package:professional_grupo_vista_app/pages/about_us_page.dart';
import 'package:professional_grupo_vista_app/pages/all_chats_page.dart';
import 'package:professional_grupo_vista_app/pages/register_page.dart';

import '../pages/home_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => const HomePage(),
  'login': (_) => const LoginPage(),
  'register': (_) => const RegisterPage(),
  'loading': (_) => const LoadingPage(),
  'about': (_) => const AboutUsPage(),
  'allChatsPage': (_) => const AllChatsPage(),
};
