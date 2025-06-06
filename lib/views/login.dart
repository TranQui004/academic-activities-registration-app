import 'dart:ui';
import 'package:doan/services/auth.dart';
import 'package:doan/views/home_page_khoa.dart';
import 'package:doan/views/home_page_sv.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController _mssvController = TextEditingController();
  final TextEditingController _matkhauController = TextEditingController();
  bool _obscureText = true;
  bool? _doanKhoa = false;
  final _fbAuth = AuthService();

  Future<void>  _Login() async{
    if(_formKeyLogin.currentState!.validate()){
      if(!_doanKhoa!){
        final u = await _fbAuth.DangNhapSinhVienByMSSV(_mssvController.text, _matkhauController.text);
        if(u != null){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePageSv(sv: u),
            ));
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sai mật khẩu hoặc mã số sinh viên'))
        );
      }
      else{
        final u = await _fbAuth.DangNhapDoanKhoa(_mssvController.text, _matkhauController.text);
        if(u != null){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePageKhoa(dk: u,),
              ));
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sai mật khẩu hoặc mã số sinh viên'))
        );
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi đăng nhập vui lòng thử lại'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/bannerHUIT.png'),
        backgroundColor: AppColors.primary,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child: SizedBox(
        height: SizeDevice.height - AppBar().preferredSize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child:  Container(
                    height: SizeDevice.height - 300,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      image: DecorationImage(
                        image: AssetImage('assets/images/HUIT.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      width: SizeDevice.width,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            'ĐĂNG NHẬP HỆ THỐNG',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 50),
                          //+Form
                          Form(
                            key: _formKeyLogin,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 24, right: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.fromBorderSide(
                                        BorderSide(color: AppColors.baseColor)
                                    ),
                                    boxShadow: [AppColors.boxShadow],
                                  ),
                                  child: Padding( padding: EdgeInsets.only(left: 6.0, right: 6.0),
                                    child: TextFormField(
                                      controller: _mssvController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.person),
                                        hintText: 'Nhập mã số sinh viên',
                                        labelText: 'Mã số sinh viên',
                                        labelStyle: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 18,
                                        ),
                                      ),
                                      validator: (_mssvController){
                                        if(_mssvController == null || _mssvController.isEmpty){
                                          return 'Vui lòng nhập MSSV';
                                        }
                                        return null ;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Container(
                                  margin: EdgeInsets.only(left: 24, right: 24),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.fromBorderSide(
                                        BorderSide(color: AppColors.baseColor)
                                    ),
                                    boxShadow: [AppColors.boxShadow],
                                  ),
                                  child: Padding( padding: EdgeInsets.only(left: 6.0, right: 6.0),
                                    child: TextFormField(
                                      controller: _matkhauController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(Icons.password),
                                        suffixIcon: IconButton(
                                            icon: Icon(
                                                _obscureText ? Icons.visibility_off : Icons.visibility
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                        ),
                                        hintText: 'Nhập mật khẩu',
                                        labelText: 'Mật khẩu',
                                        labelStyle: TextStyle(
                                          color: AppColors.textBlack,
                                          fontSize: 18,
                                        ),
                                      ),
                                      validator: (_matkhauController){
                                        if(_matkhauController == null || _matkhauController.isEmpty){
                                          return 'Vui lòng nhập mật khẩu';
                                        }
                                        return null ;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                                Padding(
                                  padding: EdgeInsets.only(right: 22, left: 20),
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
                                        onPressed: _Login,
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
                                Padding(
                                  padding: EdgeInsets.only(right: 12, left: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Dành cho Đoàn, Khoa',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Checkbox(
                                          value: _doanKhoa,
                                          onChanged: (bool? value){
                                            setState(() {
                                              _doanKhoa = value;
                                            });
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                                //DN bằng GG
                                // SizedBox(height: 22,),
                                // Container(
                                //   height: 60,
                                //   width: 330,
                                //   child: ElevatedButton.icon(
                                //     style: ElevatedButton.styleFrom(
                                //       backgroundColor: Colors.white,
                                //       foregroundColor: Colors.black,
                                //       elevation: 3,
                                //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(8),
                                //         side: const BorderSide(color: Colors.grey),
                                //       ),
                                //     ),
                                //     icon: Image.asset(
                                //       'assets/images/Google_logo.png',
                                //       height: 24,
                                //     ),
                                //     label: const Text(
                                //       'Đăng nhập bằng Google',
                                //       style: TextStyle(fontSize: 16),
                                //     ),
                                //     onPressed: () async {
                                //       // User? user = await _fbAuth.signInWithGoogle();
                                //     },
                                //   ),
                                // ),
                              ],
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Container(
                height: 300,
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
      ),),
    );
  }
}
