import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/slice_rekam_medis_controller.dart';

class SliceRekamMedisView extends GetView<SliceRekamMedisController> {
  const SliceRekamMedisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliceRekamMedisView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SliceRekamMedisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
