import 'package:doan/main.dart';
import 'package:flutter/material.dart';

class SVDangKy{
    final String MSSV;
    final String HoTen;
    final String Lop;
    final String TinhTrang;
    SVDangKy({
        required this.MSSV,
        required this.HoTen,
        required this.Lop,
        required this.TinhTrang,
    });
}


class DSSinhVienThamGia extends StatefulWidget{
    const DSSinhVienThamGia({super.key});
    @override
    State<StatefulWidget> createState() => _DSSinhVienThamGiaState();
}

class _DSSinhVienThamGiaState extends State<DSSinhVienThamGia>{
    
    List<SVDangKy> dsDangKy = [
        SVDangKy(MSSV: '2001224715', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH06', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '2', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '3', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '4', HoTen: 'Mguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '5', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '6', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '1', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '2', HoTen: 'Aguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '3', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '4', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '5', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '6', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '1', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '2', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '3', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '4', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '5', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '6', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '1', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '2', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '3', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '4', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '5', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '6', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '1', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '2', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '3', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '4', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '5', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
        SVDangKy(MSSV: '6', HoTen: 'Nguyễn Văn Thành', Lop: '13DHTH03', TinhTrang: 'Đăng ký'),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarBase(titleText: 'Danh sách tham gia'),

            body: SingleChildScrollView(
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
                                            onPressed: (){},
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
            DataColumn(label: Center(
                child: Text('STT'),
            )),
            DataColumn(label: GestureDetector(
                onTap: null,
                child: Text('MSSV'),
            )),
            DataColumn(label: GestureDetector(
                onTap: null,
                child: Text('Họ và Tên'),
            )),
            DataColumn(label: GestureDetector(
                onTap: null,
                child: Text('Lớp'),
            )),
            DataColumn(label: GestureDetector(
                onTap: null,
                child: Text('Tình trạng'),
            )),
        ];
    }

    List<DataRow> _createRows () {
        var i = 0;
        return dsDangKy.map((e){
            i++;
            return DataRow(cells: [
                DataCell(Center(child: Text(i.toString()))),
                DataCell(Text(e.MSSV.toString())),
                DataCell(Text(e.HoTen.toString())),
                DataCell(Text(e.Lop.toString())),
                DataCell(Text(e.TinhTrang.toString())),
            ]);
        }).toList();
    }
}