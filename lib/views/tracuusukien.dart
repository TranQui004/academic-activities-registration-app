import 'dart:ui';
import 'package:doan/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TraCuuSuKien extends StatelessWidget{
  const TraCuuSuKien({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(titleText: 'Tìm sự kiện'),
      body: Expanded( child: Container(
        decoration: BoxDecoration(color: AppColors.baseColor),
        child: Padding(padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nhập mã, tên, ngày sự kiện',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
               child: Text('Tìm kiếm sự kiện',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textWhite,
                ),
               ),
              ),
            ],
          ),
        ),
      ),),
      drawer: DrawerBaseKhoa(),
    );
  }
}