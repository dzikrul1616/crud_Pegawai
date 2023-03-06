import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/addcontenview_controller.dart';

class AddcontenviewView extends GetView<AddcontenviewController> {
  const AddcontenviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddcontenviewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddcontenviewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
