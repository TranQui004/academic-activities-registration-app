import 'dart:ui';
import 'package:doan/main.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bannerHUIT.png'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 600,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  image: DecorationImage(
                    image: AssetImage('assets/images/HUIT.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: AppColors.textWhite.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 22),
                            Text(
                              'ĐĂNG NHẬP HỆ THỐNG',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 40),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nhập mã sinh viên',
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(height: 22),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 18,
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nhập mật khẩu',
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                ),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding: EdgeInsets.only(right: 12, left: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Quên mật khẩu?',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.primary,
                                      ),
                                    ),
                                  ),

                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        'Đăng nhập',
                                        style: TextStyle(
                                          color: AppColors.textWhite,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              color: AppColors.primary,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Giới Thiệu',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),
                    Text(
                      'Đồ án môn học: Ứng dụng đăng ký hoạt động Seminar, đoàn đội.',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Thành viên:',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '⭐Lăng Minh Hải',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '⭐Trần Trọng Quí',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '⭐Nguyễn Văn Thành',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '⭐Nguyễn Hoành Thịnh',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
