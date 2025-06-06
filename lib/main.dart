import 'dart:convert';
import 'package:doan/models/doankhoa.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:doan/views/creating_event.dart';
import 'package:doan/views/thongtindiendanh.dart';
import 'package:doan/views/xacnhandangky.dart';
import 'firebase_options.dart';
import 'views/home_page_sv.dart';
import 'views/qr_scanner.dart';
import 'views/login.dart';
import 'views/student_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SinhVienProvider()),
        ChangeNotifierProvider(create: (context) => DoanKhoaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeDevice.setSizeDevice(context);
    return MaterialApp(
      title: "Ứng dụng đăng ký hoạt động",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: LoginView(),
    );
  }
}

class SizeDevice {
  static double height = 0;
  static double width = 0;

  static void setSizeDevice(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
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
  const AppBarBase({super.key, required this.titleText});
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

class ScaffoldWithDrawer extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  const ScaffoldWithDrawer({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: const DrawerBase(),
    );
  }
}


//Sinh vien
class DrawerBase extends StatelessWidget {
  const DrawerBase({super.key});

  Future<void> LogOut(BuildContext context) async{
    SinhVienProvider().clear();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sv = Provider.of<SinhVienProvider>(context).sinhVien;
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
                            child: Image.memory(base64Decode(sv!.AnhUrl.split(',').last),
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
                                sv!.mssv ?? 'Lỗi xác định mssv',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              Text(
                                sv!.hoTen ?? 'Lỗi xác định tên',
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: ListView(
                    children: [
                      //list item drawer
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageSv(sv: sv,),));
                        },
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Trang chính',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      //list item drawer
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentCardScreen(sv: sv,),));
                        },
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageSv(sv: sv,),));
                        },
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Điểm danh hoạt động',
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
                          'Lịch sử đăng ký hoạt động',
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
                          'Tra cứu hoạt động',
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
              onPressed: () async{
                await LogOut(context);
              },
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


//KHoa
class DrawerBaseKhoa extends StatelessWidget {
  const DrawerBaseKhoa({super.key});

  Future<void> LogOut(BuildContext context) async{
    DoanKhoaProvider().clear();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginView()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dk = Provider.of<DoanKhoaProvider>(context).doanKhoa;

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
                            child: Image.network(
                              dk!.AnhUrl,
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
                                'Mã đoàn, khoa: ${dk!.MaDK}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'KHOA ${dk!.TenDK.toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textWhite,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
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
              
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: ListView(
                    children: [
                      //list item drawer
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePageKhoa(dk: dk),));
                        },
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: Text(
                          'Trang chính',
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
                          'Tra cứu sự kiện',
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
                          'Quản lý sự kiện',
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
                          'Tra cứu thông tin sinh viên',
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
    super.key,
    required this.valueCurrent,
    required this.valueMax,
  });

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
    super.key,
    required this.valueCurrent,
    required this.valueMax,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
