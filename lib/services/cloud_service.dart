import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan/models/event.dart';
import 'package:doan/models/sinhvien.dart';
import 'package:doan/models/sv_dangky.dart';
import 'package:doan/views/ds_sv_dangky.dart';

class CloudService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'events';

  Future<void> addEvent(Event newEv) async {
    Map<String, dynamic> event = newEv.toMap();
    event.remove('id');
    DocumentReference eventRef = await _firestore.collection(_collection).add(event);
    print('Them tt🛎️');
  }

  Future<void> updateEvent(String id, Map<String, dynamic> event) async {
    await _firestore.collection(_collection).doc(id).update(event);
  }

  Future<void> capNhatEvent(Event event) async {
    try{
      print(event.id);
      await _firestore.collection(_collection).doc(event.id).update(event.toMap());
      print('done');
    } catch(e){}
  }

  Future<void> deleteEvent(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection(_collection).snapshots();
  }

  Future<Event?> layEventGanNhat() async {
    final now = DateTime.now();

    final querySnapshot = await _firestore
        .collection(_collection)
        .where('TGToChuc', isGreaterThan: Timestamp.fromDate(now))
        .orderBy('TGToChuc')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return Event.fromMap(data);
    } else {
      return null;
    }
  }


  Stream<QuerySnapshot> get5Events() {
    final now = DateTime.now();
    final endDate = DateTime(now.year, now.month + 1, now.day - 1);

    return _firestore
      .collection(_collection)
      .where('TGToChuc', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
      .where('TGToChuc', isLessThan: Timestamp.fromDate(endDate))
      .orderBy('TGToChuc')
      .limit(5)
      .snapshots();
  }


  Future<Map<String, dynamic>?> getEventById(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (doc.exists) {
      final data = doc.data();
      data?['id'] = doc.id;
      return data;
    } else {
      return null;
    }
  }

  Future<SinhVien?> LaySV(String id) async {
    try {
      final doc = await _firestore.collection('SinhVien').doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        data?['id'] = doc.id;
        return SinhVien.fromMap(data!);
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy thông tin sinh viên: $e');
      return null;
    }
  }

  Future<List<SVDangKy>?> LayDanhSachDangKy(String eventId) async {
    try {
      final eventRef = _firestore.collection(_collection).doc(eventId);
      final registrationsSnapshot = await eventRef.collection('DangKy').get();
      List<SVDangKy> newdata = [];

      await Future.wait(registrationsSnapshot.docs.map((doc) async {
        final data = doc.data();
        data['id'] = doc.id;
        SinhVien? sv = await LaySV(data['id']);
        data['HoTen'] = sv!.hoTen;
        data['lop'] = sv.lop;
        newdata.add(SVDangKy.fromMap(data));
      }));

      return newdata;
    } catch (e) {
      print('Lỗi khi lấy danh sách đăng ký: $e');
      return [];
    }
  }
}
