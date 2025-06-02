import 'package:cloud_firestore/cloud_firestore.dart';

class CloudService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'events';

  Future<void> addEvent(Map<String, dynamic> event) async {
    DocumentReference eventRef = await _firestore.collection(_collection).add(event);
    await eventRef.collection('DangKy').add({});
  }

  Future<void> updateEvent(String id, Map<String, dynamic> event) async {
    await _firestore.collection(_collection).doc(id).update(event);
  }

  Future<void> deleteEvent(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }

  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection(_collection).snapshots();
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

}
