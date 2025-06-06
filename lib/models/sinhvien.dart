import 'package:flutter/cupertino.dart';

class SinhVien {
  final String mssv;
  final String hoTen;
  final DateTime ngaySinh;
  final String email;
  final String khoa;
  final String lop;
  final String bacDaoTao;
  final DateTime ngayVaoTruong;
  final String trangThai;
  final int diemRenLuyen;
  final String Sdt;
  final String NienKhoa;
  final String AnhUrl;
  final String MatKhau;


  SinhVien({
    required this.mssv,
    required this.hoTen,
    required this.ngaySinh,
    required this.email,
    required this.khoa,
    required this.lop,
    required this.bacDaoTao,
    required this.ngayVaoTruong,
    required this.trangThai,
    required this.diemRenLuyen,
    required this.Sdt,
    required this.NienKhoa,
    required this.AnhUrl,
    required this.MatKhau,
  });

  factory SinhVien.fromMap(Map<String, dynamic> map) {
    return SinhVien(
      mssv: map['id'],
      hoTen: map['HoTen'],
      ngaySinh: map['NgaySinh'].toDate(),
      email: map['email'],
      khoa: map['Khoa'],
      lop: map['Lop'],
      bacDaoTao: map['BacDaoTao'],
      ngayVaoTruong: map['NgayVaoTruong'].toDate(),
      trangThai: map['TrangThai'],
      diemRenLuyen: map['DiemRenLuyen'],
      Sdt: map['Sdt'],
      NienKhoa: map['NienKhoa'],
      AnhUrl: map['AnhUrl'],
      MatKhau: map['MatKhau']
    );
  }
}

class SinhVienProvider with ChangeNotifier {
  SinhVien? _sinhVien;

  SinhVien? get sinhVien => _sinhVien;

  void setSinhVien(SinhVien sv) {
    _sinhVien = sv;
    notifyListeners();
  }

  void clear() {
    _sinhVien = null;
    notifyListeners();
  }
}
