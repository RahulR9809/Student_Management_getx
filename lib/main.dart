import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampstudentapp/db/db_functions.dart';
import 'package:sampstudentapp/presentation/home/home.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await indataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const Homepage(),
    );
  }
}
