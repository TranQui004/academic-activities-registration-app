import 'dart:ui';
import 'package:doan/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageSv extends StatelessWidget{
  const HomePageSv({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Trang chính'),
      body: Expanded( child: Container(
        decoration: BoxDecoration(color: AppColors.baseColor),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: 300,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 239, 249, 255),
                  boxShadow: [AppColors.boxShadow]
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 60,
                      child: CircleProgressWidget(valueCurrent: 70, valueMax: 90),
                    ),

                    Positioned(
                      top: 40,
                      left: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Điểm rèn luyện',
                            style: TextStyle(
                              fontSize: 22,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Loại: Khá',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      left: 130,
                      top: 140,
                      child: Text('Hoạt động gần đây',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 90,
                      top: 160,
                      child: Container(
                        height: 1,
                        width: 200,
                        color: AppColors.primary,
                      ),
                    ),

                    
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [AppColors.boxShadow],
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  image: DecorationImage(
                    image: AssetImage('assets/images/HUIT.png'),
                    fit: BoxFit.cover,
                  )
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Padding(padding: EdgeInsets.all(24),
                    child: Text('SEMINAR HỌC THUẬT KHOA CNTT',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  boxShadow: [AppColors.boxShadow],
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  image: DecorationImage(
                    image: AssetImage('assets/images/HUIT.png'),
                    fit: BoxFit.cover,
                  )
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Padding(padding: EdgeInsets.all(24),
                    child: Text('HOẠT ĐỘNG\nĐOÀN HUIT',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),),
      drawer: DrawerBase(),
    );
  }
}