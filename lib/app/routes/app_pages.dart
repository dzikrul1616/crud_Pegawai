import 'package:get/get.dart';

import '../modules/Addcontenview/bindings/addcontenview_binding.dart';
import '../modules/Addcontenview/views/addcontenview_view.dart';
import '../modules/Content/bindings/content_binding.dart';
import '../modules/Content/views/content_view.dart';
import '../modules/ProfilView/bindings/profil_view_binding.dart';
import '../modules/ProfilView/views/profil_view_view.dart';
import '../modules/bottombar/bindings/bottombar_binding.dart';
import '../modules/bottombar/views/bottombar_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMBAR,
      page: () =>  BottombarView(),
      binding: BottombarBinding(),
    ),
    GetPage(
      name: _Paths.ADDCONTENVIEW,
      page: () =>  AddcontenviewView(),
      binding: AddcontenviewBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL_VIEW,
      page: () => const ProfilViewView(),
      binding: ProfilViewBinding(),
    ),
    GetPage(
      name: _Paths.CONTENT,
      page: () => const ContentView(),
      binding: ContentBinding(),
    ),
  ];
}
