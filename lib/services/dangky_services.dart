import 'package:doan/services/cloud_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DangKyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addDangKy({
    required String eventId,
    required String mssv,
    required String phone,
    String status = 'Đăng ký',
  }) async {
    try {
      DocumentReference dangKyRef = _firestore
          .collection('events')
          .doc(eventId)
          .collection('DangKy')
          .doc(mssv);

      final snapshot = await dangKyRef.get();
      if (snapshot.exists) {
        return '✅ Sinh viên đã đăng ký ✅';
      }

      Map<String, dynamic> dangKyData = {
        'SinhVien': _firestore.collection('SinhVien').doc(mssv),
        'TGDangKy': FieldValue.serverTimestamp(),
        'status': status,
      };

      await dangKyRef.set(dangKyData);
      await capnhatSL(eventId);
      return '🎉 Đăng ký thành công 🎉';
    } catch (e) {
      print('Lỗi khi thêm đăng ký: $e');
      return '⚠️ Lỗi khi thêm đăng ký: $e ⚠️';
      throw Exception('Không thể thêm đăng ký: $e');
    }
  }

  Future<void> capnhatSL(String idSuKien) async{
    final data = await CloudService().getEventById(idSuKien);
    if(data != null){
      data['SLDangKy'] += 1;
      await CloudService().updateEvent(idSuKien, data);
    }
  }

  Future<void> deleteDangKy({
    required String eventId,
    required String userId,
  }) async {
    try {
      DocumentReference dangKyRef = _firestore
          .collection('events')
          .doc(eventId)
          .collection('dangky')
          .doc(userId);

      // Xóa document
      await dangKyRef.delete();
      print('Xóa đăng ký thành công cho event $eventId, user $userId');
    } catch (e) {
      print('Lỗi khi xóa đăng ký: $e');
      throw Exception('Không thể xóa đăng ký: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDangKyByEventId(String eventId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('events')
          .doc(eventId)
          .collection('dangky')
          .get();

      List<Map<String, dynamic>> dangKyList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print('Lấy danh sách đăng ký thành công cho event $eventId');
      return dangKyList;
    } catch (e) {
      print('Lỗi khi lấy danh sách đăng ký: $e');
      throw Exception('Không thể lấy danh sách đăng ký: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> streamDangKyByEventId(String eventId) {
    return _firestore
        .collection('events')
        .doc(eventId)
        .collection('dangky')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
  }
}