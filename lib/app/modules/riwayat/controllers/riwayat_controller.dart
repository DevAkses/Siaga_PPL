import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RiwayatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> realtimeRiwayat() {
    CollectionReference history = firestore.collection("histories");

    return history.orderBy('currentTimeStr', descending: true).snapshots();
  }
}
