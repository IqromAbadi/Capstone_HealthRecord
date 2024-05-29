import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/modules/masuk/controllers/masuk_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBHd7lZpfaaOwIAfKee9lMN08qfwuVxgVs",
      appId: "1:621467609416:android:7df49ba42dbcd27f0eab7d",
      messagingSenderId: "621467609416",
      projectId: "healthrecord-ad04f",
      storageBucket: "gs://healthrecord-ad04f.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(MasukController(), permanent: true);

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Record',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
