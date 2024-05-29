import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/masuk_controller.dart';

class MasukView extends GetView<MasukController> {
  const MasukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MasukView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MasukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
