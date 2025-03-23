import 'package:flutter/material.dart';
import 'package:doan/main.dart';

class ThongTinSVSauQuet extends StatelessWidget {
  const ThongTinSVSauQuet({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: ('Thông tin SV Sau Khi Quét')),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.baseColor),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/nvt.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TTSV(label: "Họ tên", value: "Nguyễn Văn Thành"),
              TTSV(label: "GT", value: "Nam"),
              TTSV(label: "MSSV", value: "2001224715"),
              TTSV(label: "Ngành", value: "Công Nghệ Thông Tin"),
              TTSV(label: "Khoa", value: "Công Nghệ Thông Tin"),
              TTSV(label: "Lớp", value: "13DHTH03"),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý hủy
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 80),

                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Hủy",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý điểm danh
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(120, 80),
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Điểm danh",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TTSV extends StatelessWidget {
  final String label;
  final String value;

  TTSV({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(value, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
