import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ubah_pemeriksaan_controller.dart';

class UbahPemeriksaanView extends GetView<UbahPemeriksaanController> {
  const UbahPemeriksaanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UbahPemeriksaanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UbahPemeriksaanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
