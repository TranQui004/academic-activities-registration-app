import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/main.dart';
import 'package:doan/models/doankhoa.dart';
import 'package:doan/models/event.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/views/creating_event.dart';
import 'package:doan/views/event_management.dart';
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
  Event? e;

  @override
  void initState() {
    super.initState();
    loadSK();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoanKhoaProvider>(context, listen: false).setDoanKhoa(widget.dk);
    });

  }

  Future<void> loadSK() async{
    Event? ev = await CloudService().layEventGanNhat();
    if(ev!=null){
      setState(() {
        e = ev;
      });
    }
  }

  String dinhDangThoiGianSukien(DateTime tg) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final inputDay = DateTime(tg.year, tg.month, tg.day);

    final diffDays = inputDay.difference(today).inDays;

    if (diffDays == 0) {
      if (tg.isAfter(now)) {
        return 'Sắp diễn ra';
      } else {
        return 'Đã diễn ra';
      }
    } else if (diffDays == 1) {
      return 'Ngày mai';
    } else {
      return '${tg.day.toString().padLeft(2, '0')}/'
          '${tg.month.toString().padLeft(2, '0')}/'
          '${tg.year} - '
          '${tg.hour.toString().padLeft(2, '0')}:'
          '${tg.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dk = Provider.of<DoanKhoaProvider>(context).doanKhoa;
    return Scaffold(
      appBar: AppBarBase(titleText: 'Trang chính'),
      body: e == null ? Center(child: CircularProgressIndicator(),) :
      Expanded( child: Container(
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
                      child: CircleProgressWidget(valueCurrent: e!.SLDangKy, valueMax: e!.SLToiDa),
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
                      left: 20,
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
                            child: Text(e!.TenSuKien ?? '',
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
                      left: 20,
                      top: 130,
                      child: Text('Tình trạng: ${dinhDangThoiGianSukien(e!.TGToChuc)}',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    Positioned(
                      left: 20,
                      top: 160,
                      child: Container(
                        height: 1,
                        width: 150,
                        color: AppColors.primary,
                      ),
                    ),

                    Positioned(
                      top: 170,
                      child: Container(
                        height: 120,
                        width: SizeDevice.width,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: CloudService().get5Events(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('Không có sự kiện'));
                            }

                            final events = snapshot.data!.docs;

                            return GridView.builder(
                              padding: EdgeInsets.all(12),
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2 / 3,
                              ),
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final data =
                                events[index].data()
                                as Map<String, dynamic>;
                                final ten = data['TenSuKien'] ?? 'Không tên';
                                final ngay =
                                (data['TGToChuc'] as Timestamp).toDate();

                                return Container(
                                  width: 200,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ten,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Ngày: ${ngay.day}/${ngay.month}/${ngay.year}',
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
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

                  GestureDetector(child: Container(
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
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EventManagementScreen(),));
                  },),
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