import 'package:doan/models/sinhvien.dart';

class SVDangKy{
  final String MSSV;
  final String HoTen;
  final String Lop;
  final DateTime TGDangKy;
  final String TinhTrang;
  SVDangKy({
    required this.MSSV,
    required this.HoTen,
    required this.Lop,
    required this.TGDangKy,
    required this.TinhTrang,
  });

  factory SVDangKy.fromMap(Map<String, dynamic> map) {
    return SVDangKy(
        MSSV: map['id'],
        HoTen: map['HoTen'],
        Lop: map['lop'],
        TGDangKy: map['TGDangKy'].toDate(),
        TinhTrang: map['status'],
    );
  }
}