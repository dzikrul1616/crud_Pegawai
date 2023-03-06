import 'package:get/get.dart';

import '../controllers/addcontenview_controller.dart';

class AddcontenviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcontenviewController>(
      () => AddcontenviewController(),
    );
  }
}
