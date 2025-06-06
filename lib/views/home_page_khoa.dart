import 'dart:ui';
import 'package:doan/main.dart';
import 'package:doan/models/doankhoa.dart';
import 'package:doan/views/creating_event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePageKhoa extends StatefulWidget {
  final DoanKhoa dk;
  const HomePageKhoa({
    super.key, required this.dk});
  @override
  State<StatefulWidget> createState() => _HomePageKhoaState();
}


class _HomePageKhoaState extends State<HomePageKhoa>{
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoanKhoaProvider>(context, listen: false).setDoanKhoa(widget.dk);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dk = Provider.of<DoanKhoaProvider>(context).doanKhoa;
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
                      right: 30,
                      child: CircleProgressWidget(valueCurrent: 270, valueMax: 300),
                    ),

                    Positioned(
                      top: 135,
                      right: 8,
                      child: Text('Số lượng tham gia',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ),

                    Positioned(
                      top: 20,
                      left: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sự kiện đang diễn ra',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 202,
                            child: Text('Seminar AI của tương lai Seminar dhuhdjhduheu AI của tương lai',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textBlack,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      left: 30,
                      top: 130,
                      child: Text('Tình trạng: Sắp bắt đầu',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 30,
                      top: 160,
                      child: Container(
                        height: 1,
                        width: 150,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      boxShadow: [AppColors.boxShadow],
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                        image: AssetImage('assets/images/HUIT.png'),
                        fit: BoxFit.cover,
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      alignment: Alignment.center,
                      child: Text('TẠO\nHOẠT ĐỘNG',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CreatingEvent(),));
                    },
                  ),

                  Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      boxShadow: [AppColors.boxShadow],
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      image: DecorationImage(
                        image: AssetImage('assets/images/HUIT.png'),
                        fit: BoxFit.cover,
                      )
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      alignment: Alignment.center,
                      child: Text('QUẢN LÝ\nHOẠT ĐỘNG',
                        style: TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),),
      drawer: DrawerBaseKhoa(),
    );
  }
}