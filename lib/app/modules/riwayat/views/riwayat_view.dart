import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Alarm',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF30E5D0),
        leading: BackButtonWidget(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.realtimeRiwayat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          var listNotification = snapshot.data!.docs;
          return ListView.builder(
            itemCount: listNotification.length,
            itemBuilder: (context, index) {
              var riwayat =
                  listNotification[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(
                  '${riwayat['title']}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${riwayat['description']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'Tanggal: ${riwayat['date']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      'Waktu: ${riwayat['time']}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
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
