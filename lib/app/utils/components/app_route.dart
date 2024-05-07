import 'package:flutter/material.dart';
import 'package:simple_blog/app/screens/craete_blog.dart';
import 'package:simple_blog/app/screens/home.dart';
// routes
class AppRoute {
  static const String home = '/home';
  static const String createBlog = '/createBlog';



  static var route = <String, Widget Function(BuildContext)>{
    home: (context) => const HomeScreen(),
    createBlog: (context) => const CreateBlog(),
  };
}