import 'package:doan/main.dart';
import 'package:doan/models/event.dart';
import 'package:doan/models/sv_dangky.dart';
import 'package:doan/services/cloud_service.dart';
import 'package:doan/views/taoqrdiemdanh.dart';
import 'package:flutter/material.dart';

class DSSinhVienThamGia extends StatefulWidget{
    final Event idSK;

    DSSinhVienThamGia({
        super.key,
        required this.idSK
    });

    @override
    _DSSinhVienThamGiaState createState() => _DSSinhVienThamGiaState();
}

class _DSSinhVienThamGiaState extends State<DSSinhVienThamGia>{
    List<SVDangKy>? dsDangKy;

    @override
    void initState() {
        super.initState();
        loadDSDV();
    }

    Future<void> loadDSDV () async {
        try {
            final data = await CloudService().LayDanhSachDangKy(widget.idSK.id);
            if (mounted) {
                setState(() {
                    dsDangKy = data;
                });
            }
        } catch (e) {
            print("Lỗi khi load dữ liệu: $e");
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarBase(titleText: 'Danh sách tham gia'),

            body: dsDangKy == null ? Center(child: CircularProgressIndicator(),) :
            SingleChildScrollView(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(padding: EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                    children: [
                                        ElevatedButton(
                                            onPressed: (){},
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12)
                                                )
                                            ),
                                            child: Row(children: [
                                                Icon(Icons.print),
                                                SizedBox(width: 4,),
                                                Text('In danh sách')
                                            ],)
                                        ),
                                        SizedBox(width: 12,),
                                        ElevatedButton(
                                            onPressed: (){

                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12)
                                                )
                                            ),
                                            child: Row(children: [
                                                Icon(Icons.find_in_page_outlined),
                                                SizedBox(width: 4,),
                                                Text('Tìm trong danh sách') 
                                            ],)
                                        ),
                                    ],
                                ),
                                SizedBox(height: 6),
                                ElevatedButton(
                                    onPressed: (){
                                        Navigator.push(context, 
                                            MaterialPageRoute(builder: (context) => QRCodePage(event: widget!.idSK!),)
                                        );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        )
                                    ),
                                    child: Row(children: [
                                        Icon(Icons.qr_code),
                                        SizedBox(width: 4,),
                                        Text('Tạo QR điểm danh')
                                    ],)
                                ),
                                SizedBox(height: 12),
                                DataTable(
                                    columnSpacing: 20,
                                    horizontalMargin: 10,
                                    columns: _createColumns(),
                                    rows: _createRows()
                                ),
                            ],
                        ),
                    ),
                ),
            ),

            drawer: DrawerBaseKhoa(),
        );
    }

    List<DataColumn> _createColumns () {
        return [
            DataColumn(label: Text('STT')),
            DataColumn(label: Text('MSSV')),
            DataColumn(label: Text('Họ và Tên')),
            DataColumn(label: Text('Lớp')),
            DataColumn(label: Text('Thời gian đăng ký')),
            DataColumn(label: Text('Tình trạng')),
        ];
    }

    List<DataRow> _createRows () {
        var i = 0;
        return dsDangKy!.map((e){
            i++;
            return DataRow(cells: [
                DataCell(Center(child: Text(i.toString()))),
                DataCell(Text(e.MSSV.toString())),
                DataCell(Text(e.HoTen.toString())),
                DataCell(Text(e.Lop.toString())),
                DataCell(Text(e.TGDangKy.toString())),
                DataCell(Text(e.TinhTrang.toString())),
            ]);
        }).toList();
    }
}