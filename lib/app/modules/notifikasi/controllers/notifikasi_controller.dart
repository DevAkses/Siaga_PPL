import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotifikasiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Satu kali baca data 
  Future<QuerySnapshot<Object?>> readNotification() async {
    CollectionReference notification = firestore.collection("notifications");

    return notification.get();
  }

  // Realtime Baca Data
  Stream<QuerySnapshot<Object?>> realtimeNotif() {
    CollectionReference notification = firestore.collection("notifications");

    return notification.orderBy('currentTimeStr', descending: true).snapshots();
  }
}
