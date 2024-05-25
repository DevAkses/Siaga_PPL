import 'package:get/get.dart';

import '../controllers/panggilan_darurat_controller.dart';

class PanggilanDaruratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanggilanDaruratController>(
      () => PanggilanDaruratController(),
    );
  }
}
