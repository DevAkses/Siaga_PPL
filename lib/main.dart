import 'package:coba_uas/notification_service.dart';
import 'package:coba_uas/database_service.dart';
import 'package:coba_uas/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coba_uas/app/utils/loading.dart';
import 'package:coba_uas/app/controllers/auth_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAGSaWx0bxLzVGDqQyePz0OH2NdWdsHiZE",
            authDomain: "coba-uas-2e05c.firebaseapp.com",
            projectId: "coba-uas-2e05c",
            storageBucket: "coba-uas-2e05c.appspot.com",
            messagingSenderId: "813991370846",
            appId: "1:813991370846:web:f0273e63fc44b4538794cf"));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  await Permission.notification.request();
  await NotificationService().initNotification();
  await DatabaseService().initDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (kDebugMode) {
          print(snapshot);
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.HOME
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
