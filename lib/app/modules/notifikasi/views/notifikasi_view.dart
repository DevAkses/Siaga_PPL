import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifikasi Alarm',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF30E5D0),
          leading: BackButtonWidget(),
        ),
        body:
            // REALTIME GET DATA
            StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.realtimeNotif(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (kDebugMode) {
                print(snapshot.data!.docs);
              }
              var listNotification = snapshot.data!.docs;
              return ListView.builder(
                itemCount: listNotification.length,
                itemBuilder: (context, index) {
                  var notifikasi =
                      listNotification[index].data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(
                      '${notifikasi["title"]}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${notifikasi["description"]}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'Tanggal: ${notifikasi["date"]}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          'Waktu: ${notifikasi["time"]}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )

        // ONE TIME GET DATA
        // FutureBuilder<QuerySnapshot<Object?>>(
        //   future: controller.readNotification(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       print(snapshot.data!.docs);
        //       var listNotification = snapshot.data!.docs;
        //       return ListView.builder(
        //         itemCount: listNotification.length,
        //         itemBuilder: (context, index) => ListTile(
        //           title: Text(
        //               '${(listNotification[index].data() as Map<String, dynamic>)["title"]}'),
        //           subtitle: Text(
        //               '${(listNotification[index].data() as Map<String, dynamic>)["description"]}'),
        //         ),
        //       );
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
