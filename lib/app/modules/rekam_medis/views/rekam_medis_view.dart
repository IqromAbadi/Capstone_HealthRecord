import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekam_medis_controller.dart';

class RekamMedisView extends GetView<RekamMedisController> {
  const RekamMedisView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RekamMedisView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RekamMedisView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
