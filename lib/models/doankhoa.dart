import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DoanKhoa{
  final String MaDK;
  final String TenDK;
  final String TruongDK;
  final String AnhUrl;
  final String MatKhau;

  DoanKhoa({
    required this.MaDK,
    required this.TenDK,
    required this.TruongDK,
    required this.AnhUrl,
    required this.MatKhau,
  });


  factory DoanKhoa.fromMap(Map<String, dynamic> map) {
    return DoanKhoa(
        MaDK: map['MaDK'],
        TenDK: map['TenKhoa'],
        TruongDK: map['TruongKhoa'],
        AnhUrl: map['AnhUrl'],
        MatKhau: map['MatKhau'],
    );
  }
}

class DoanKhoaProvider with ChangeNotifier {
  DoanKhoa? _doanKhoa;

  DoanKhoa? get doanKhoa => _doanKhoa;

  void setDoanKhoa(DoanKhoa dk) {
    _doanKhoa = dk;
    notifyListeners();
  }

  void clear() {
    _doanKhoa = null;
    notifyListeners();
  }
}