import 'package:doan/views/login.dart';
import 'package:flutter/material.dart';
import 'package:doan/views/list_event.dart';
import 'package:doan/views/event_management.dart';
import 'package:doan/views/student_card.dart';
import 'package:doan/views/login.dart';

void main() {
  //runApp(const EventListApp());
  //runApp(const EventManagementScreen());
  runApp(const StudentCardScreen());
}

class EventListApp extends StatelessWidget {
  const EventListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ứng dụng đăng ký hoạt động",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const LoginView(),
    );
  }
}

class AppColors {
  static const Color primary = Color.fromARGB(255, 0, 91, 184);
  static const Color textBlack = Color.fromARGB(255, 50, 50, 50);
  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);
}
