import 'package:floward_task/screens/home_screen.dart';
import 'package:floward_task/screens/user_posts_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeRoute = '/';
  static const String postsRoute = '/posts';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const HomeScreen(),
    '/posts': (context) => const UserPostsScreen(),
  };
}
