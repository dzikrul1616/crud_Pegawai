import 'package:get/get.dart';

import '../controllers/profil_view_controller.dart';

class ProfilViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilViewController>(
      () => ProfilViewController(),
    );
  }
}
