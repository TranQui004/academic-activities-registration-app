import 'package:doan/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SVDangKy{
    final String MSSV;
    final String HoTen;
    bool DiemDanh;

    SVDangKy({
        required this.MSSV,
        required this.HoTen,
        this.DiemDanh = false,
    });
}


class DSSinhVienThamGia extends StatefulWidget{
    const DSSinhVienThamGia({super.key});
    @override
    State<StatefulWidget> createState() => _DSSinhVienThamGiaState();
}

class _DSSinhVienThamGiaState extends State<DSSinhVienThamGia>{
    
    List<SVDangKy> dsDangKy = [
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: true),
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: false),
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: true),
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: false),
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: true),
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', DiemDanh: true),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarBase(titleText: 'Danh sách tham gia'),

            body: Container(
                width: double.infinity,
                color: AppColors.baseColor,
                child: Padding(padding: EdgeInsets.all(8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Row(children: [
                                Text('Chủ đề:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                SizedBox(width: 4,),
                                SizedBox(width: 315,
                                    child: Text('AI hướng đến tương lai',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textBlack,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                    ),
                                ),
                            ],),
                            SizedBox(height: 12,),
                            Row(children: [
                                Text('Thời gian:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                SizedBox(width: 4,),
                                SizedBox(width: 300,
                                    child: Text('14/04/2004',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textBlack,
                                        ),
                                    ),
                                ),
                            ],),
                            SizedBox(height: 12,),
                            Row(children: [
                                Text('Địa điểm:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                SizedBox(width: 4,),
                                SizedBox(width: 300,
                                    child: Text('Hội trường C HUIT',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.textBlack,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                    ),
                                ),
                            ],),
                            SizedBox(height: 50,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        ElevatedButton(onPressed: (){},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(255, 40, 216, 0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                ),
                                            ),
                                            child: Text('In danh sách',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.textBlack,
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [AppColors.boxShadow]
                                    ),
                                    child: Padding(padding: EdgeInsets.all(4), child: ListView.builder(
                                        itemCount: dsDangKy.length,
                                        itemBuilder: (context, index) {
                                            return Card(
                                                margin: EdgeInsets.all(2),
                                                child: ListTile(
                                                    title: Text(dsDangKy[index].HoTen, style: TextStyle(fontWeight: FontWeight.bold)),
                                                    subtitle: Text("MSSV: ${dsDangKy[index].MSSV}"),
                                                    trailing: Text('Điểm danh: ${dsDangKy[index].DiemDanh ? 'Y' : 'N'}', style: TextStyle(color: Colors.green, fontSize: 16)),
                                                ),
                                            );
                                        }
                                    ),),
                                ),
                            ),
                        ],
                    ),
                ),
            ),

            drawer: DrawerBaseKhoa(),
        );
    }
}