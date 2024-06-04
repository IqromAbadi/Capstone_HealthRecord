import 'package:get/get.dart';

import '../controllers/slice_rekam_medis_controller.dart';

class SliceRekamMedisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SliceRekamMedisController>(
      () => SliceRekamMedisController(),
    );
  }
}
