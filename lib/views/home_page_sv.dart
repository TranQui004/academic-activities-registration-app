import 'dart:ui';
// import 'package:doan/services/auth.dart';
import 'package:doan/services/auth.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/views/list_event.dart';
import 'package:doan/views/login.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageSv extends StatefulWidget {
  final SinhVien sv;
  HomePageSv({super.key, required this.sv});
  @override
  _MyHomePageSv createState() => _MyHomePageSv();
}

class _MyHomePageSv extends State<HomePageSv> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadSinhVien();
    });
  }

  Future<void> loadSinhVien() async {
    final user = await widget.sv;
    if (user != null) {
        Provider.of<SinhVienProvider>(
          context,
          listen: false,
        ).setSinhVien(user);
    } else {
      print('Lỗi: user hoặc email bị null');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sv = Provider.of<SinhVienProvider>(context).sinhVien;
    if (sv == null) {
      return const Center(child: CircularProgressIndicator());
    }
    print(sv);

    String? getLoaiRenLuyen(int? drl) {
      if (drl == null) return null;
      if (drl > 70) return 'Giỏi';
      if (drl >= 60 && drl <= 70) return 'Khá';
      if (drl >= 50 && drl <= 60) return 'Trung bình';
      if (drl < 50) return 'Yếu';
    }

    return ScaffoldWithDrawer(
      appBar: AppBarBase(titleText: 'Trang chính'),
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(color: AppColors.baseColor),
          child: ListView(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  height: 300,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 239, 249, 255),
                    boxShadow: [AppColors.boxShadow],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 60,
                        child: CircleProgressWidget(
                          valueCurrent: sv.diemRenLuyen,
                          valueMax: 90,
                        ),
                      ),

                      Positioned(
                        top: 40,
                        left: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Điểm rèn luyện',
                              style: TextStyle(
                                fontSize: 22,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Loại: ${getLoaiRenLuyen(sv.diemRenLuyen)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textBlack,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: 140,
                        child: Container(
                          width: SizeDevice.width,
                          child: Text(
                            'Hoạt động gần đây',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: SizeDevice.width / 4,
                        top: 160,
                        child: Container(
                          height: 1,
                          width: SizeDevice.width - 200,
                          color: AppColors.primary,
                        ),
                      ),

                      Positioned(
                        top: 170,
                        child: Container(
                          height: 120,
                          width: SizeDevice.width,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: CloudService().get5Events(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(child: Text('Không có sự kiện'));
                              }

                              final events = snapshot.data!.docs;

                              return GridView.builder(
                                padding: EdgeInsets.all(12),
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 2 / 3,
                                    ),
                                itemCount: events.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      events[index].data()
                                          as Map<String, dynamic>;
                                  final ten = data['TenSuKien'] ?? 'Không tên';
                                  final ngay =
                                      (data['TGToChuc'] as Timestamp).toDate();

                                  return Container(
                                    width: 200,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ten,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Ngày: ${ngay.day}/${ngay.month}/${ngay.year}',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: GestureDetector(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: [AppColors.boxShadow],
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                        image: AssetImage('assets/images/cntt.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 370,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'SEMINAR HỌC THUẬT KHOA CNTT',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventsListScreen(),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [AppColors.boxShadow],
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    image: DecorationImage(
                      image: AssetImage('assets/images/doan.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'HOẠT ĐỘNG\nĐOÀN HUIT',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
