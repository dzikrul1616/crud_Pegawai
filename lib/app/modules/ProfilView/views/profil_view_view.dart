import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profil_view_controller.dart';

class ProfilViewView extends GetView<ProfilViewController> {
  const ProfilViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProfilViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
