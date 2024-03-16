import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MainController());
  runApp(const MainApp());
}

class MainApp extends GetView<MainController> {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: controller.prymaryColor,
      ),
      home: const HomePage(),
    );
  }
}
