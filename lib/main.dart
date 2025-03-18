import 'package:doan/views/home_page_sv.dart';
import 'package:doan/views/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePageSv(),
    );
  }
}

class AppColors{
  static const Color primary = Color.fromARGB(255, 0, 91, 184);
  static const Color textBlack = Color.fromARGB(255, 50, 50, 50);
  static const Color textWhite = Color.fromARGB(255, 255, 255, 255);
}

class AppBarBase extends StatelessWidget implements PreferredSizeWidget{
  final String titleText;
  const AppBarBase({Key? key, required this.titleText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: IconThemeData(color: AppColors.textWhite),
      title: Text(titleText,
        style: TextStyle(
          color: AppColors.textWhite,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.bell, color: AppColors.textWhite,),)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DrawerBase extends StatelessWidget{
  const DrawerBase({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 215, 215, 215),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.primary,
                child: Padding(padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset("assets/images/nvt.png",
                              height: 80, width: 80, fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 14,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('2001224715',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textWhite,
                                ),
                              ),
                              Text('Nguyễn Văn Thành',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(padding: EdgeInsets.all(18),
              //   child: Expanded(
              //     child: 
              //   ),
              // ),  
              Expanded(
                child: Padding(padding: EdgeInsets.only(left: 12), child: ListView(
                  children: [
                    //list item drawer
                    TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text('Thông tin sinh viên',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //list item drawer
                    TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text('Hoạt động đã đăng ký',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //list item drawer
                    TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text('Hoạt động đã tham gia',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 80,),
                  ],
                ),
              ),),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 10, right: 10,
            child: ElevatedButton(
              onPressed: (){},
              child: Text('Đăng xuất',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}