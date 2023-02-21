import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/screen/todo_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(ResponsiveSizer(
    builder: (context, orientation, screenType) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TodoApp(),
      ),
    );
  }
}
