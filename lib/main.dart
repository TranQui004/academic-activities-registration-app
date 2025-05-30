import 'package:doan/views/ds_sv_dangky.dart';
import 'package:doan/views/tracuusukien.dart';
import 'package:doan/views/chitietsukien.dart';
import 'package:doan/views/creating_event.dart';
import 'package:doan/views/home_page_khoa.dart';
import 'package:doan/views/thongtindiendanh.dart';
import 'package:doan/views/xacnhandangky.dart';
import 'views/home_page_sv.dart';
import 'views/qr_scanner.dart';
import 'views/login.dart';
import 'views/student_info.dart';
import 'package:flutter/material.dart';
import 'package:doan/views/list_event.dart';
import 'package:doan/views/event_management.dart';
import 'package:doan/views/student_card.dart';
import 'package:doan/views/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleEvent = Event(
      id: '1',
      TenSuKien: 'HUIT Open Day 2025',
      MoTa: 'Sự kiện giới thiệu về trường HUIT',
      DDToChuc: 'Trường ĐH Công Thương TP.HCM',
      DoiTuong: 'Sinh viên năm nhất',
      DonViToChuc: 'Khoa CNTT',
      HDChinh: 'Giới thiệu trường',
      LoaiHD: 'Sự kiện',
      SLDangKy: 50,
      SLToiDa: 100,
      TGKetThuc: DateTime(2025, 5, 30, 17, 0), // 17:00
      TGToChuc: DateTime(2025, 5, 30, 8, 0),   // 8:00
      ThongTinThem: 'Mang theo thẻ sinh viên\nTrang phục lịch sự\nĐi đúng giờ \nHUIT Day là sự kiện thường niên do Khoa Công nghệ Thông tin – Trường Đại học Công nghiệp Thực phẩm TP.HCM (HUFI) tổ chức, nhằm tôn vinh tinh thần học tập, sáng tạo và kết nối trong cộng đồng sinh viên CNTT. Đây là dịp đặc biệt để sinh viên, giảng viên, cựu sinh viên và các doanh nghiệp đối tác cùng nhau giao lưu, chia sẻ kiến thức, công nghệ và định hướng nghề nghiệp',
      UrlAnh: 'https://scontent.fsgn8-3.fna.fbcdn.net/v/t39.30808-6/485766398_1066688488824666_554276560066969464_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeE30DTlB70JI6brCkOWUudipCRvCfn3m92kJG8J-feb3cLZT2C0AdsO2iB3k_PhtiKqWZdT_SgvfhQFvd0uEM8s&_nc_ohc=adowegutYQEQ7kNvwHEgqCc&_nc_oc=AdnBkmh-BkZQChj6dIcfjUnhnqghymDTgX9013QZ_--q3h03KDYXvIhCuHNW0V9cN_3YGq3CG6PuXG0lVZXF3Opk&_nc_zt=23&_nc_ht=scontent.fsgn8-3.fna&_nc_gid=Bd6C89hd-a2ZFk6WdnOr-Q&oh=00_AfKOitgN7g5U5hI2p1R4iuyVo2Kwhqgtjmr82lcWs42rRQ&oe=683F9E6B'
    );

    return MaterialApp(
      title: "Ứng dụng đăng ký hoạt động",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: EventDetail(event: sampleEvent),
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
//Sinh vien
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


//KHoa
class DrawerBaseKhoa extends StatelessWidget {
  const DrawerBaseKhoa({super.key});
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
                              "assets/images/HUIT.png",
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
                                'CNTT',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'KHOA CÔNG NGHỆ THÔNG TIN',
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
