import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthrecord/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: Center(
          child: IconButton(
              onPressed: () {
                Get.toNamed(Routes.MASUK);
              },
              icon: Icon(Icons.arrow_back))),
    );
  }
}
