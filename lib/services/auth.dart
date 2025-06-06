import 'package:doan/models/doankhoa.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AuthService {
  // static final FirebaseAuth fbAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // User? get user => fbAuth.currentUser;

  Future<SinhVien?> DangNhapSinhVienByMSSV(String mssv, String mk) async {
    final doc = await _firestore.collection('SinhVien').doc(mssv).get();
    if (doc.exists) {
      final data = doc.data();
      if(data?['MatKhau'] == mk){
        data?['id'] = doc.id;
        return SinhVien.fromMap(data!);
      }
    }
    print('Loi DN');
    return null;
  }

  Future<DoanKhoa?> DangNhapDoanKhoa(String mssv, String mk) async {
    final doc = await _firestore.collection('DoanKhoa').doc(mssv).get();
    if (doc.exists) {
      final data = doc.data();
      if(data?['MatKhau'] == mk){
        data?['MaDK'] = doc.id;
        print('object');
        return DoanKhoa.fromMap(data!);
      }
    }
    print('Loi DN');
    return null;
  }
}