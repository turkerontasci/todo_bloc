import 'package:flutter/material.dart';
import 'package:todo_bloc/src/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Colors.white,
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(
          primary: Colors.lightBlueAccent,
        ),
      ),
      home: HomePage(),
    );
  }
}
