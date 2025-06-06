import 'dart:convert';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:doan/main.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:flutter/material.dart';

class StudentCardScreen extends StatelessWidget {
  final SinhVien sv;

  const StudentCardScreen({
    super.key,
    required this.sv,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Thông tin sinh viên'),
      drawer: DrawerBase(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/HUIT.png'),
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
              opacity: 0.8,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                StudentCardView(sv: sv,),

                const SizedBox(height: 24),

                // Thông tin thêm về thẻ
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      AppColors.boxShadow
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Thông tin thẻ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF263238),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.school, "Khóa học: ${sv.NienKhoa}"),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.info_outline, "Trạng thái: ${sv.trangThai}"),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }
}

class StudentCardView extends StatelessWidget {
  final SinhVien sv;

  const StudentCardView({
    super.key,
    required this.sv,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          AppColors.boxShadow
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/HUIT_logo.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 40,
                        color: Color(0xFF1565C0),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TRƯỜNG ĐẠI HỌC CÔNG THƯƠNG TP.HCM",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "THẺ SINH VIÊN",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF455A64),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Phần chính của thẻ
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(sv.AnhUrl.split(',').last)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Thông tin sinh viên
                Text(
                  sv.hoTen,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "MSSV: ${sv.mssv}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFE1F5FE),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "Khoa: ${sv.khoa}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFE1F5FE),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "Lớp: ${sv.lop}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFE1F5FE),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Mã vạch
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(children: [_buildBarcode(sv.mssv)]),
                ),

                const SizedBox(height: 16),

                // Thời hạn thẻ
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Niên khoá: ${sv.NienKhoa}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcode(String id) {
    return BarcodeWidget(
        data: id, 
        barcode: Barcode.codabar(),
        width: SizeDevice.width,
        height: 100,
    );
  }
}
