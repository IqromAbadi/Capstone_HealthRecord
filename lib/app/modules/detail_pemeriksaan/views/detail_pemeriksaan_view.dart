import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_pemeriksaan_controller.dart';

class DetailPemeriksaanView extends GetView<DetailPemeriksaanController> {
  const DetailPemeriksaanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPemeriksaanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailPemeriksaanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
