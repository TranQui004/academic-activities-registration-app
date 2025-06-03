import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:doan/main.dart';
import 'package:doan/models/event.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:intl/intl.dart';


class ThongTinSVSauQuet extends StatelessWidget {
  final SinhVien sv;
  final Event sk;

  const ThongTinSVSauQuet({
    super.key,
    required this.sv,
    required this.sk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Thông tin SV Sau Khi Quét'),
      drawer: const DrawerBase(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/HUIT.png',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.white.withOpacity(0.9)),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "✅ Điểm Danh Hoạt Động",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("📌 Thông Tin Hoạt Động", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          TTSV(label: "Tên hoạt động", value: sk.TenSuKien ?? "Chưa có tên hoạt động"),
                          TTSV(
                            label: "Ngày tổ chức",
                            value: DateFormat('HH:mm - dd/MM/yyyy').format(sk.TGToChuc),
                          ),

                          TTSV(label: "Địa điểm", value: sk.DDToChuc ?? "Chưa có địa điểm"),
                          const Divider(height: 30, thickness: 1),
                          const Text("🎓 Thông Tin Sinh Viên", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 15),
                          Center(
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blueAccent, width: 3),
                                image: DecorationImage(
                                  image: MemoryImage(base64Decode(sv.AnhUrl.split(',').last)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TTSV(label: "MSSV", value: sv.mssv),
                          TTSV(label: "Họ và Tên", value: sv.hoTen),
                          TTSV(label: "Lớp", value: sv.lop),
                          TTSV(label: "Khoa", value: sv.khoa),
                          TTSV(label: "Niên khoá", value: sv.NienKhoa),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Xử lý điểm danh
                              },
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text(
                                "ĐIỂM DANH NGAY",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),

                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TTSV extends StatelessWidget {
  final String label;
  final String value;

  const TTSV({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


