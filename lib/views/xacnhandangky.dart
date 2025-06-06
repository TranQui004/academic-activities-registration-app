
import 'package:doan/models/sinhvien.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/services/dangky_services.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/services/dangky_services.dart';
import 'package:flutter/material.dart';
import 'package:doan/main.dart';

class XacNhanDangKyScreen extends StatefulWidget {
  final IconData? iconCheck;
  final Color? colorIcon;
  final String? statusRegis;
  final String idSuKien;
  final String? TenSK;
  final String? DdToChuc;
  final DateTime? TgToChuc;
  final bool? TrangThai;

  const XacNhanDangKyScreen({
    Key? key,
    this.iconCheck = Icons.help_outline,
    this.colorIcon = Colors.blueAccent,
    this.statusRegis = 'wait',
    required this.idSuKien,
    this.DdToChuc,
    this.TgToChuc,
    this.TenSK,
    this.TrangThai = false
  }) : super(key: key);

  @override
  _XacNhanDangKyScreenState createState() => _XacNhanDangKyScreenState();
}

class _XacNhanDangKyScreenState extends State<XacNhanDangKyScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final sv = Provider.of<SinhVienProvider>(context).sinhVien!;

    return Scaffold(
      appBar: AppBarBase(titleText: 'Xác nhận đăng ký'),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.baseColor),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: SingleChildScrollView(
              child: Container(height: SizeDevice.height - 100, child: Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(16.0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Nút "Trở lại" ở đầu trang
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                ); // Quay lại màn hình trước
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    'Trở lại',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ), // Khoảng cách giữa nút "Trở lại" và nội dung
                        
                        Icon(widget.iconCheck, size: 150, color: widget.colorIcon),
                        // Icon(Icons.check_circle_outline, size: 150, color: Colors.blue),
                        // SizedBox(height: 320),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yêu cầu khi tham gia sự kiện\n${widget.TenSK}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '- Có mặt đúng thời gian',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '- Mặc áo đồng phục hoặc áo sơ mi trắng có cổ',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '- Nếu vắng mặt -4 điểm rèn luyện',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeDevice.height - 600),

                        widget.TrangThai! ?
                            Center(child: Text('Bạn đã đăng ký'),)
                        : Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value ?? false;
                                });
                              },
                            ),
                            Text('Tôi chấp nhận điều kiện'),
                          ],
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                            ),
                            onPressed:
                                _isChecked
                                    ? () async {
                                      String r = await DangKyService().addDangKy(
                                        eventId: widget.idSuKien,
                                        // mssv: sv!.mssv,
                                        // phone: sv!.Sdt
                                        mssv: '2001224715',
                                        phone: '0765084233'
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Thông báo đăng ký tham gia', style: TextStyle(fontSize: 14),),
                                            content: Text(
                                              r,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(
                                                    context,
                                                  ).pop(); // Đóng dialog
                                                  Navigator.pop(context);
                                                },

                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                    : null,
                            child: Text(
                              'Đăng Ký',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),
            ),
          ),
        ],
      ),
      drawer: DrawerBase(),
    );
  }
}

void navigateToXacNhanDangKy(BuildContext context, String id) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => XacNhanDangKyScreen(
      idSuKien: id,
      iconCheck: Icons.check_circle_outline, colorIcon: Colors.green,
      TrangThai: true,
    )),
  );
}
