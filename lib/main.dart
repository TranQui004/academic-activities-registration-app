import 'package:doan/views/chitietsukien.dart';
import 'package:doan/views/xacnhandangky.dart';

import 'views/home_page_sv.dart';
import 'views/login.dart';
import 'views/student_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: XacNhanDangKyScreen(),
    );
  }
}

class AppColors {
  static const Color primary = Color.fromARGB(255, 0, 91, 184);
  static const Color textBlack = Color.fromARGB(255, 50, 50, 50);
  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color baseColor = Color.fromARGB(255, 207, 226, 255);

  static const BoxShadow boxShadow = BoxShadow(
    color: Color.fromARGB(255, 140, 140, 140),
    blurRadius: 10,
    spreadRadius: 2,
    offset: Offset(2, 2),
  );
}

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  const AppBarBase({Key? key, required this.titleText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.textWhite),
      title: Text(
        titleText,
        style: TextStyle(color: AppColors.textWhite, fontSize: 22),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.bell, color: AppColors.textWhite),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DrawerBase extends StatelessWidget {
  const DrawerBase({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.baseColor,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primary,
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                              "assets/images/nvt.png",
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2001224715',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              Text(
                                'Nguyễn Văn Thành',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(padding: EdgeInsets.all(18),
              //   child: Expanded(
              //     child:
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: ListView(
                    children: [
                      //list item drawer
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Thông tin sinh viên',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      //list item drawer
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Hoạt động đã đăng ký',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      //list item drawer
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Hoạt động đã tham gia',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Đăng xuất',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleProgressWidget extends StatelessWidget {
  final int valueCurrent;
  final int valueMax;

  const CircleProgressWidget({
    Key? key,
    required this.valueCurrent,
    required this.valueMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: 1.0,
            strokeWidth: 16,
            valueColor: AlwaysStoppedAnimation(
              const Color.fromARGB(255, 235, 235, 235),
            ),
          ),
        ),

        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: valueCurrent / valueMax,
            strokeWidth: 22,
            valueColor: AlwaysStoppedAnimation(
              const Color.fromARGB(255, 149, 228, 81),
            ),
          ),
        ),

        Text(
          '$valueCurrent / $valueMax',
          style: TextStyle(color: AppColors.textBlack, fontSize: 18),
        ),
      ],
    );
  }
}

class LineProgressWidget extends StatelessWidget {
  final int valueCurrent;
  final int valueMax;

  const LineProgressWidget({
    Key? key,
    required this.valueCurrent,
    required this.valueMax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(12),
              value: 1.0,
              minHeight: 6,
              valueColor: AlwaysStoppedAnimation(
                const Color.fromARGB(255, 235, 235, 235),
              ),
            ),
          ),

          Positioned.fill(
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(12),
              value: valueCurrent / valueMax,
              minHeight: 6,
              valueColor: AlwaysStoppedAnimation(
                const Color.fromARGB(255, 149, 228, 81),
              ),
            ),
          ),

          Text(
            'Số lượng đã đăng ký $valueCurrent / $valueMax',
            style: TextStyle(color: AppColors.textBlack, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
