import 'dart:ui';
import 'package:doan/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentInfoScreen extends StatelessWidget {
  const StudentInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Thông tin sinh viên'),

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.baseColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120, width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/nvt.png'),
                    ),
                  ]
                ),
                const SizedBox(height: 16),
                Text(
                  "Nguyễn Văn Thành",
                  style: TextStyle(
                    color: AppColors.textBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "MSSV: 2001224715",
                  style: TextStyle(fontSize: 16, color: AppColors.textBlack),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListView(
                      children: [
                        _buildInfoStudent(
                          FontAwesomeIcons.graduationCap,
                          "Trạng thái",
                          "Đang học",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.school,
                          "Lớp học",
                          "13DHTH03",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.userGraduate,
                          "Bậc đào tạo",
                          "Đại học",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.building,
                          "Khoa",
                          "Khoa Công nghệ Thông tin",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.laptopCode,
                          "Ngành",
                          "Công nghệ thông tin",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.code,
                          "Chuyên ngành",
                          "Công nghệ phần mềm",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.calendar,
                          "Ngày vào trường",
                          "19/09/2022",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.mapMarkerAlt,
                          "Cơ sở",
                          "ĐHCT TP.HCM",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.book,
                          "Loại hình đào tạo",
                          "Chính quy",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.idBadge,
                          "Khóa học",
                          "2022",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.phone,
                          "SDT",
                          "012345689",
                        ),
                        _buildInfoStudent(
                          FontAwesomeIcons.envelope,
                          "Email",
                          "nvt@gmail.com",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      drawer: DrawerBase(),
    );
  }

  Widget _buildInfoStudent(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.textWhite,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value, style: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}
