import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_pemeriksaan_controller.dart';

class TambahPemeriksaanView extends GetView<TambahPemeriksaanController> {
  const TambahPemeriksaanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TambahPemeriksaanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TambahPemeriksaanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
